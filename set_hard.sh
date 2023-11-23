

sed -i '/fsType = "tmpfs";/a\      options = [ "defaults" "size=2G" "mode=755" ];' /mnt/etc/nixos/hardware-configuration.nix

sed -i '/fsType = "zfs";/a\      options = [ "zfsutil" ];' /mnt/etc/nixos/hardware-configuration.nix

sed -i '/options = \[ "zfsutil" \];/{x;s/^/x/;/xx/{x;a \
      neededForBoot = true;
    ;b};x}' /mnt/etc/nixos/hardware-configuration.nix

