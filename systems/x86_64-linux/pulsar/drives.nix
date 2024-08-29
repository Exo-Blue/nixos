{ ... }:

{
    # Setup the primary disk
    disko.devices.disk.primary = {
        device = "/dev/sda";
        type = "disk";
        content = {
            type = "gpt";
            partitions = {
                esp = {
                    # This code corresponds to a EFI system partition
                    type = "EF00";
                    size = "500M";
                    content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                    };
                };
                root = {
                    # Take up the rest of the space on the disk
                    size = "100%";
                    content = {
                        type = "btrfs";
                        subvolumes = {
                            "@" = {
                                mountpoint = "/";
                                mountOptions = [ "noatime" ];
                            };
                            "@home" = {
                                mountpoint = "/home";
                                mountOptions = [ "compress=zstd" "noatime" ];
                            };
                            "@nix" = {
                                mountpoint = "/nix";
                                mountOptions = [ "compress=zstd" "noatime" ];
                            };
                        };
                    };
                };
            };
        };
    };
}
