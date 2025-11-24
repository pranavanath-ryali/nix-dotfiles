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

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;

        prime = {
            intelBusId = "PCI:0:2:0";
		    nvidiaBusId = "PCI:2:0:0";
        };
    };
}
