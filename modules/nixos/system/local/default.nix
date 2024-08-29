{ config, lib, ... }:

let
  cfg = config.poperigby.system.locale;
in
{
    options.poperigby.system.locale.enable = lib.mkEnableOption "Enable locale settings";

    config = lib.mkIf cfg.enable {
        # Select internationalization properties.
        i18n.defaultLocale = "en_US.UTF-8";
    };
}