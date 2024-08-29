{ pkgs, ... }:

{
    # Set password for root user
    users.users.nixos.password = "nixos";

    # Enable New CLI and Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Useful packages for installation and recovery
    environment.systemPackages = with pkgs; [
        btrfs-progs
        curl
        git
        networkmanager
        parted
        exoblue.installer
    ];

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05";
}
