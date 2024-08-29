{ config, lib, ... }:

let
  cfg = config.exoblue.hardware.audio;
in
{
    options.exoblue.hardware.audio.enable = lib.mkEnableOption "Enable audio";

    config = lib.mkIf cfg.enable {
        services.pipewire = {
            enable = true;
            # Use PipeWire as the primary sound server
            audio.enable = true;
            # Enable Wireplumber, a modular session / policy manager
            wireplumber.enable = true;
            # Enable ALSA and PulseAudio emulation
            alsa = {
                enable = true;
                support32Bit = true;
            };
            pulse.enable = true;
        };
    };
}
