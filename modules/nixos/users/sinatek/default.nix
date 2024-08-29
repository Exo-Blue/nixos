{ config, lib, ... }:

let
    cfg = config.exoblue.users.sinatek;
in
{
    options.exoblue.users.sinatek.enable = lib.mkEnableOption "sinatek user";

    config = lib.mkIf cfg.enable {
        users.users.sinatek = {
            isNormalUser = true;
            description = "Dylan Lasjunies";
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIACkYD2uAp4VUmEsryUa9/2mx8ikqG3S6GJlJVpbDNKy louga31@exoblue"
            ];
            extraGroups = [
                # For sudo access
                "wheel"
                # For libvirt access
                "libvirtd"
                # For ADB access
                "adbusers"
                # For Docker access
                "docker"
                # For network access
                "networkmanager"
                # For PulseAudio access
                "audio"
            ];
        };

        # Tell Home Manager information about the user
        home-manager.users.sinatek.home = {
            username = "sinatek";
            homeDirectory = "/home/sinatek";
        };
    };
}