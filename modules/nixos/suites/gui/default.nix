{ config, lib, ... }:

let
    cfg = config.exoblue.suites.gui;
in
{
    options.exoblue.suites.gui = {
        enable = lib.mkEnableOption "Enable GUI";
    };

    config = lib.mkIf cfg.enable {
        exoblue = {
            services = {
                udisks2.enable = true;
            };
        };

        # Required for Sway to launch
        security.polkit.enable = true;

        # Required for Swaylock to work
        security.pam.services.swaylock = {};

        # Required for tweaking GTK settings
        programs.dconf.enable = true;
    };
}
