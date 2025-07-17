{ config, pkgs, ... }:
{
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            vpl-gpu-rt
        ];
    };

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