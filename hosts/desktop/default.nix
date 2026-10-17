{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "turtle";

  boot.kernelPackages = pkgs.linuxPackages_zen;

  fileSystems."/home/pepi/SSD" ={
    device = "/dev/disk/by-uuid/b07fe4f4-0297-458a-a514-7fd5883d6682";
    fsType = "btrfs";
    options = [ "defaults" "noatime" ];
  };

  fileSystems."/home/pepi/HDD" ={
    device = "/dev/disk/by-uuid/de616433-a7bf-47c1-970b-6603d3053a6a";
    fsType = "btrfs";
    options = [ "defaults" "noatime" ];
  };

  boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';


    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # Force low-latency audio processing for gaming
      extraConfig.pipewire."99-lowlatency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;      # ~5.3ms latency (use 128 for ~2.6ms)
          "default.clock.min-quantum" = 128;
          "default.clock.max-quantum" = 512;
        };
      };
    };

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
