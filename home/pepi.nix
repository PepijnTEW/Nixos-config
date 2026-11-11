{ pkgs, config, lib, ... }:

{
  home.username = "pepi";
  home.homeDirectory = "/home/pepi";
  home.stateVersion = "26.05"; # Updated to current stable stateVersion (adjust if on unstable)

  # Font visibility for non-Nix apps
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    qbittorrent
    firefox
    chromium
    obsidian
    prismlauncher
    zed-editor
    docker
    wlogout
    wine
    jetbrains-mono
    monaspace
    inter
    wl-clipboard
    hyprshot
    slurp
    spotify
    pulsemixer
    wechat
    anki
    discord
    solaar
    hyprlock
    easyeffects
    gimp
    localsend
    bluetui
    lutris

    emacs-pgtk
    kdePackages.kdenlive
    git
    ripgrep
    fd
    coreutils
    findutils
    xdg-desktop-portal-gtk
    thunar
    clang
    cmake
    gnumake
    libtool
    zstd
    shellcheck
    nerd-fonts.symbols-only
    wpsoffice
    php
    php.packages.composer
    intelephense
    nodejs
    typescript-language-server
    vscode-langservers-extracted
  ];

  home.sessionVariables = {
    PATH = "$HOME/.config/emacs/bin:$PATH";
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    client.enable = true;
  };


  gtk = {
    enable = true;
    theme = {
      name = "WhiteSur-Light";
      package = pkgs.whitesur-gtk-theme;
    };
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
    cursorTheme = {
      name = "WhiteSur-cursors";
      package = pkgs.whitesur-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = builtins.readFile ./modules/hyprland.lua;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          fit_mode = "cover";
          monitor = "DP-1";
          path = "~/Pictures/wallpaper.jpg";
        }
      ];
    };
  };

  # Portal Configuration
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = [ "hyprland" ];
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      margin-top = 12;
      margin-left = 12;
      margin-right = 12;
      height = 30;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "battery" ];

      "hyprland/workspaces" = {
        format = "{icon}";
        format-icons = {
          active = "●";
          default = "○";
        };
      };

      clock = {
        format = "{:%a %d %b %H:%M}";
      };

      network = {
        format-wifi = "󰤨";
        format-ethernet = "󰈀";
        format-disconnected = "󰤭";
        tooltip-format = "{ifname} via {gwaddr}";
        on-click = "${pkgs.kitty}/bin/kitty -e nmtui";
      };

      pulseaudio = {
        format = "{icon}  {volume}%";
        format-icons = {
          default = ["󰕿" "󰖀" "󰕾"];
        };
        scroll-step = 5;
        on-click = "${pkgs.kitty}/bin/kitty -e ${pkgs.pulsemixer}/bin/pulsemixer";
      };
    }];
    style = ''
      * {
        font-family: "Inter";
        font-size: 13px;
        border: none;
        font-weight: 500;
      }

      window#waybar {
        background-color: transparent;
      }

      .modules-left, .modules-center, .modules-right {
        background-color: rgba(255, 255, 255, 0.7);
        border-radius: 12px;
        border: 1px solid rgba(0, 0, 0, 0.08);
        box-shadow: 0 4px rgba(0, 0, 0, 0.05);
        padding: 2px 8px;
        color: #1D1D1F;
      }

      #workspaces button {
        padding: 0 4px;
        color: rgba(0, 0, 0, 0.3);
      }

      #workspaces button.active {
        color: #000000;
      }

      #clock, #network, #pulseaudio, #battery {
        padding: 0 8px;
      }
    '';
  };

  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 350;
      location = "center";
      show = "drun";
      prompt = "Search Apps...";
      allow_images = true;
      image_size = 32;
      insensitive = true;
      layer = "overlay";
      term = "kitty";
    };
    style =''
      * {
        font-family: "Inter";
        font-size: 14px;
      }

      window {
        background-color: rgba(255, 255, 255, 0.7);
        border-radius: 16px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
      }

      #input {
        background-color: rgba(255, 255, 255, 0.55);
        border-radius: 10px;
        border: 1px solid rgba(0, 0, 0, 0.08);
        margin: 16px;
        padding: 10px 16px;
        color: #1D1D1F;
      }

      #inner-box {
        margin: 0 16px 16px 16px;
        background-color: transparent;
      }

      #outer-box {
        background-color: transparent;
      }

      #scroll {
        margin: 0 ;
        background-color: transparent;
      }

      #entry {
        padding: 8px 12px;
        border-radius: 8px;
        margin: 2px 0;
      }

      #entry:selected {
        background-color: rgba(0, 255, 122, 255, 0.15);
        color: #000000;
      }

      #text {
        color: #1D1D1F;
        margin-left: 10px;
      }
    '';
  };

  programs.kitty = {
    enable = true;

    font = {
      name = "Monaspace Neon";
      package = pkgs.monaspace;
      size = 12;
    };

    settings = {
      window_padding_width = 12;
      confirm_os_window_close = 0;
    };

    extraConfig = ''
      font_features MonaspaceNeon-Regular +calt +liga
      font_features MonaspaceNeon-Bold    +calt +liga
      font_features MonaspaceNeon-Italic  +calt +liga
    '';
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "/home/pepi/Pictures/fastfetch.jpg";
        type = "kitty";
        width = 17;
        padding = {
          right = 2;
        };
      };
      modules = [
        "title"
        "os"
        "wm"
        "break"
        "cpu"
        "gpu"
        "memory"
        "break"
        "datetime"
      ];
    };
  };
}
