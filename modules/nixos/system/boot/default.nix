{ config, lib, ... }:

let
  cfg = config.exoblue.system.bootloader;
in
{
    options.exoblue.system.bootloader.enable = lib.mkEnableOption "Enable bootloader settings";

    config = lib.mkIf cfg.enable {
        boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
    };
}