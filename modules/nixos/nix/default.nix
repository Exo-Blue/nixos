{ config, lib, pkgs, ... }:

let
  cfg = config.exoblue.nix;
in
{
    options.exoblue.nix.enable = lib.mkEnableOption "Nix tweaks";

    config = lib.mkIf cfg.enable {
        nix = {
            # Use Lix, for a better experience
            # https://lix.systems
            package = pkgs.lix;

            settings = {
                # Enable New CLI and Flakes
                experimental-features = [ "nix-command" "flakes" ];
                # Only allow users in the `wheel` group to access Nix
                allowed-users = [ "@wheel" ];
            };
            # Every day, detects files in the store that have identical contents,
            # and replaces them with hard links to a single copy.
            # See here for why this is done daily instead of constantly: https://github.com/NixOS/nix/issues/6033
            optimise.automatic = true;
            # Perform garbage collection weekly to maintain low disk usage
            gc = {
                automatic = true;
                dates = "weekly";
                options = "--delete-older-than 7d";
            };
        };
    };
}
