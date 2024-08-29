# Settings relevant to every home

{ config, lib, ... }:

{
    options.exoblue.configDir = lib.mkOption {
        type = lib.types.path;
        description = "Location of my flake configuration repository";
        default = "${config.home.homeDirectory}/Projects/nixos";
        example = "${config.home.homeDirectory}/config";
        apply = builtins.toString;
    };

    config = {
        # Make programs use XDG directories whenever supported
        home.preferXdgDirectories = true;

        # Allow setting default applications
        xdg.mimeApps.enable = true;

        # Nicely reload system units when changing configurations
        systemd.user.startServices = "sd-switch";
    };
}
