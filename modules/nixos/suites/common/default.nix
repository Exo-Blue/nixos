{ config, lib, pkgs, ... }:

let
  cfg = config.exoblue.suites.common;
in
{
    options.exoblue.suites.common.enable = lib.mkEnableOption "common settings";

    config = lib.mkIf cfg.enable {
        # Specifies where my flake is located for nh
        environment.sessionVariables.FLAKE = "/home/sinatek/nixos";

        # Use the latest version of the Linux kernel
        boot.kernelPackages = pkgs.linuxPackages_latest;

        exoblue = {
            nix.enable = true;
            # services = {
            #     distrobox.enable = true;
            #     envfs.enable = true;
            #     ld.enable = true;
            #     smartd.enable = true;
            # };
            system = {
                bootloader.enable = true;
                locale.enable = true;
                zram.enable = true;
            };
            users = {
                enable = true;
                sinatek.enable = true;
            };
        };
    };
}
