{ pkgs, ... }:

{
    exoblue = {
        suites = {
            common.enable = true;
            gaming.enable = true;
            gui = {
                enable = true;
                adaptiveSync = false;
                resolution = "1920x1080";
                refreshRate = 60;
            };
        };
    };

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "24.05";
}