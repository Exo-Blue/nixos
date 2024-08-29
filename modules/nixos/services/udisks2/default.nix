{ config, lib, ... }:

let
    cfg = config.exoblue.services.udisks2;
in
{
    options.exoblue.services.udisks2.enable = lib.mkEnableOption "Enable udisks2";

    config = lib.mkIf cfg.enable {
        services.udisks2 = {
            enable = true;
        };
    };
}
