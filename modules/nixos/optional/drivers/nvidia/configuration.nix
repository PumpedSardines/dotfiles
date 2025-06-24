{ intelBusId, nvidiaBusId, config, pkgs, ... }:
{
  hardware.opengl = {
    enable = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime.offload.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId = intelBusId;
      nvidiaBusId = nvidiaBusId;
    };
  }; 
  environment.systemPackages = with pkgs; [
    lshw
  ];
}
