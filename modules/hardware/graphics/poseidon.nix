{ ... }:
{
  flake.nixosModules.poseidonGpuDriversModule = { pkgs, ... }: {
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # Required for modern Intel GPUs (Xe iGPU and ARC)
        intel-media-driver # VA-API (iHD) userspace
        vpl-gpu-rt # oneVPL (QSV) runtime

        # Optional (compute / tooling):
        intel-compute-runtime # OpenCL (NEO) + Level Zero for Arc/Xe
      ];
    };
    hardware.enableRedistributableFirmware = true;
    # boot.kernelParams = [ "i915.force_probe=46a8" ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
    };
  };
}
