{
    disko,
    git,
    gum,
    sops,
    writeShellScriptBin,
    ...
}:

writeShellScriptBin "installer" ''
# Fail if piped commands fail
set -uo pipefail

CONFIG_DIR="$HOME/config"

# Search the current directory and any parent directories for a file
search_up() {
    local filename=$1
    local current_dir=$PWD

    # Loop until the root directory is reached
    while [ "$current_dir" != "/" ]; do
        # Check if the file exists in the current directory
        if [ -e "$current_dir/$filename" ]; then
          echo "$current_dir/$filename"
          return 0
        fi
        # Move to the parent directory
        current_dir=$(dirname "$current_dir")
    done

    return 1
}

# Don't allow running as root. It's dangerous.
if [ "$(id -u)" -eq 0 ]; then
    echo "Running as root is dangerous. Please try running again with a regular user."
    exit 1
fi

# Clone my NixOS configuration repository if it's not already there
if [ ! -d "$CONFIG_DIR" ]; then
    ${git}/bin/git clone https://github.com/Exo-Blue/nixos "$CONFIG_DIR"
fi

# Ask which system to install
echo "Which system would you like to install?"
TARGET_HOST=$(ls -1 "$CONFIG_DIR/systems/x86_64-linux" | ${gum}/bin/gum choose)

# Put the host's LUKS password in /tmp/luks_password if it uses LUKS
if grep -q "luks" "$CONFIG_DIR/systems/x86_64-linux/$TARGET_HOST/drives.nix"; then
    echo "Copying LUKS password to /tmp/luks_password"
    export SOPS_AGE_KEY_FILE=$AGE_KEY_FILE
    ${sops}/bin/sops --decrypt --extract "['$TARGET_HOST']['luks_password']" "$CONFIG_DIR/secrets/secrets.yaml" > /tmp/luks_password
fi

# Partition the disk if the user wants to
echo "The following operation will automatically partition and format your disk"
echo "based on the chosen system's Disko configuration."
if ${gum}/bin/gum confirm --default=false "Would you like to partition and format your disk?"; then
    # Confirm the user actually wants to partition the disk
    ${gum}/bin/gum confirm --default=false "Are you sure you want to continue? Disks configured with Disko will be wiped!"

     # Partition and mount disks based on the system's Disko configuration
     sudo ${disko}/bin/disko --mode disko --flake "$CONFIG_DIR#$TARGET_HOST"
fi

echo "Copying age-key.txt to /mnt"
sudo mkdir -p /mnt/var/lib/sops-nix
sudo cp "$AGE_KEY_FILE" /mnt/var/lib/sops-nix/

echo "Installing NixOS system"
if sudo nixos-install --no-root-password --flake "$CONFIG_DIR#$TARGET_HOST"; then
    echo "Done! Remove your installation media and reboot :)"
    exit 0
else
    echo "Something went wrong during the installation :("
    exit 1
fi
''
