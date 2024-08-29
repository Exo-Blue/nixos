{ ... }:

{
    imports = [
        ./drives.nix
        ./hardware.nix
    ];

    exoblue = {
        hardware = {
            audio.enable = true;
            # bluetooth.enable = true;
            # printing.enable = true;
            # scanning.enable = true;
        };
        services = {
            # backups = {
            #     enable = true;
            #     paths = [
            #         "/home/*/.local/state/backups"
            #     ];
            # };
            # geolocation.enable = true;
            # virtualization.enable = true;
        };
        suites = {
            common.enable = true;
            # gaming.enable = true;
            gui.enable = true;
        };
    };

    programs.adb.enable = true;
    time.timeZone = "Europe/Paris";
    networking.networkmanager.enable = true;

    # # Power saving
    # services.thermald.enable = true;
    # services.auto-cpufreq = {
    #     enable = true;
    #     settings = {
    #       battery = {
    #          governor = "powersave";
    #          turbo = "never";
    #       };
    #       charger = {
    #          governor = "performance";
    #          turbo = "auto";
    #       };
    #     };
    # };

    # Having SSHD enabled is pretty handy sometimes
    services.openssh.enable = true;

    # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.05";
}
