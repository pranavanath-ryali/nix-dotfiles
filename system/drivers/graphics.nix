{ config, pkgs, ... }:
{
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            intel-media-driver
            vpl-gpu-rt
            intel-compute-runtime
        ];
    };
    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
    hardware.enableRedistributableFirmware = true;
    boot.kernelParams = [ "i915.enable_guc=3" ];

    hardware.nvidia = {
        modesetting.enable = true;

        prime = {
            offload.enable = true;
            offload.enableOffloadCmd = true;

            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:2:0:0";
        };
        
        powerManagement.enable = true;
        powerManagement.finegrained = true;

        open = false;
        nvidiaSettings = true;
    };
    services.xserver.videoDrivers = [ "nvidia" ];

    environment.variables = {
        WLR_DRM_DEVICES = "/dev/dri/by-path/pci-0000:00:02.0-card";
    };
}
