{ config, lib, ... }:

let
  cfg = config.poperigby.system.zram;
in
{
    options.poperigby.system.zram.enable = lib.mkEnableOption "Enable zRAM swap";

    config = lib.mkIf cfg.enable {
        # Explanation of why I'm using zRAM, and not a swap partition/file:
        # https://askubuntu.com/questions/471912/zram-vs-zswap-vs-zcache-ultimate-guide-when-to-use-which-one#472227
        zramSwap.enable = true;
    };

}