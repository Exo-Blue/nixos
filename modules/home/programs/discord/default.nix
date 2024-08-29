{ config, lib, ... }:

let
    cfg = config.exoblue.programs.discord;
in
{
    options.exoblue.programs.discord.enable = lib.mkEnableOption "Discord";

    config = lib.mkIf cfg.enable {
        programs.nixcord = {
            enable = true;
            config = {
                plugins = {

                };
            };
        };
    };
}
