# Build the current configuration, and make it the boot default
switch:
    nh os switch .

# Build the current configuration
test:
    nh os test .

# Switch to the current configuration, and show the trace
debug:
    nh os switch . -- --show-trace

# Check if the configuration works
check:
    nix flake check

# Update the flake.lock, check if it still works, and add it to the git index
update +input="":
    nix flake update {{input}}
    # Make sure the configuration still works, and stage it if it does
    nix flake check && git add flake.*

# Update the flake.lock, and rebuild the system
upgrade +input="":
    nix flake update {{input}}
    # Only stage the flake if the switch succeeds
    nh os switch . && git add flake.*

# Pull from the repository remote and rebuild
sync:
    git pull
    nh os switch .

# Garbage collect the Nix store
clean:
    nh clean all

# Build my recovery/install ISO
build-iso:
    nix build .#isoConfigurations.skut
