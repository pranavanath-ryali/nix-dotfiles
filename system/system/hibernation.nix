{ systemSettings, lib, ... }:
lib.mkIf (systemSettings.enableHibernation) {
    swapDevices = [{
        device = "/swapfile";
        size = systemSettings.swapSizeInGb * 1024;
    }];

    boot.kernelParams = ["resume_offset=60401664"];
    boot.resumeDevice = "/dev/disk/by-uuid/2036068a-908d-41f7-b078-57fce0bbc55a";
}
