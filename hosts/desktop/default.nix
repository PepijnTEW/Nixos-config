{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "turtle";

  boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.cpu.amd.updateMicrocode = true;

  boot.kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable=true;

  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
  ];
}
