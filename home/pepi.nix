{ pkgs, config, lib, ...}:

let
	powerMenu = pkgs.writeShellScriptBin "power-menu" ''
		chosen=$(echo -e "Lock\nLogout\nSleep\nHibernate\nReboot\nShutdown" | ${pkgs.wofi}/bin/wofi --dmenu --prompt "Power Menu" --width 250 --height 270)

    case "$chosen" in
      "Lock") ${pkgs.swaylock}/bin/swaylock -f -c 000000 ;;
      "Logout") ${pkgs.sway}/bin/swaymsg exit ;;
      "Sleep") systemctl suspend ;;
      "Hibernate") systemctl hibernate ;;
      "Reboot") systemctl reboot ;;
      "Shutdown") systemctl poweroff ;;
    esac
	'';
in
{
	home.username = "pepi";
	home.homeDirectory = "/home/pepi";
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
	 	google-chrome
	 	obsidian
	 	prismlauncher
	 	zed-editor
	 	vscodium
	 	docker
		micro
		wofi
		waybar
		jetbrains-mono
		wl-clipboard
		fastfetch
		swaybg
		grim
		slurp
		spotify
		pulsemixer
		wechat
		anki
		discord
		solaar
		swaylock
		powerMenu
		easyeffects
		gimp
		localsend
	];


	wayland.windowManager.sway = {
		enable = true;
    xwayland = true;

		config = {
			modifier = "Mod4";
			terminal = "${pkgs.foot}/bin/foot";
			menu = "${pkgs.wofi}/bin/wofi";
			bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
			startup = [
			{
				command = "${pkgs.swaybg}/bin/swaybg -i ~/Pictures/wallpaper.jpg";
				always = true;
			}
			{
				command = "swaymsg workspace 1";
			}
			];

			gaps = {
				inner = 10;
				outer = 5;
				smartGaps = "off";
			};

			window = {
				border = 1;
				titlebar = false;
			};

			floating = {
				border = 1;
				titlebar = false;
			};

			colors = {
				focused = {
					border = "#D7D7DD";
					background = "#D7D7DD";
					text = "0B0B0C";
					indicator = "#D7D7DD";
					childBorder = "#D7D7DD";
				};

				unfocused = {
					border = "#D7D7DD";
					background = "#D7D7DD";
					text = "0B0B0C";
					indicator = "#D7D7DD";
					childBorder = "#D7D7DD";
				};
			};

			keybindings = let mod = "Mod4"; in lib.mkOptionDefault {
				"${mod}+Return" = "exec ${pkgs.foot}/bin/foot";
				"${mod}+Shift+q" = "kill";
				"${mod}+d" = "exec wofi --show drun --no-actions";
				"${mod}+s" = "exec grim ~/Pictures/Screenshots/screenshot-$(date +'%Y-%m-%d-%H%M%S').png";
				"${mod}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
				"${mod}+equal" = "exec wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
				"${mod}+minus" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
				"${mod}+m" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
				"${mod}+Shift+e" = "exec ${powerMenu}/bin/power-menu";
			};
		};
	};

	programs.waybar = {
		enable = true;
		settings = [{
			layer = "top";
			position = "top";
			height = 30;
			modules-left = [ "sway/workspaces" ];
			modules-center = [ "clock" ];
			modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" ];

			clock = {
				format = "[DA] {0:%d %b %Y} [TI] {0:%H:%M}";
			};

			network = {
				format-wifi = "[NET] {essid}";
				format-ethernet = "[NET] WIRED";
				format-disconnected = "[NET] NONE";
				on-click = "${pkgs.foot}/bin/foot -e nmtui";
			};

			pulseaudio = {
				format = "[VOL] {volume}%";
				format-muted = "[VOL] MUTED";
				scroll-step = 5;

				on-click = "${pkgs.foot}/bin/foot -e ${pkgs.pulsemixer}/bin/pulsemixer";
			};

			cpu = {
				format = "[CPU] {usage}%";
			};

			memory = {
				format = "[MEM] {percentage}%";
			};

		}];
		style = ''
			* {
       	font-family: "JetBrains Mono";
        font-size: 13px;
        border-radius: 0px;
      }

      window#waybar {
        background-color: #F4F4F6;
        color: #0B0B0C;
        border-bottom: 1px solid #D7D7DD;
      }

			#workspaces button {
				padding: 0 8px;
				color: #48484A;
				background: transparent
			}

			#workspaces button.focused {
				color: #0B0B0C;
				background-color: #D7D7DD;
			}

    	#clock,#network, #pulseaudio, #cpu, #memory, #battery {
      	padding: 0 10px;
      	color: #0B0B0C;
    	}
		'';
	};

	programs.foot = {
		enable = true;
		settings = {
			main = {
				font = "JetBrains Mono:size=12";
				dpi-aware = true;
				initial-color-theme = "light";
				pad = "12x12";
			};

			colors-light = {
				foreground = "0B0B0C";
				background = "F4F4F6";
			};
		};
	};

	programs.wofi = {
	  enable = true;
		style = ''
		  window {
        font-family: 'JetBrains Mono', monospace;
        font-size: 14px;
        background-color: #F4F4F6;
        border: 1px solid #D7D7DD;
        color: #0B0B0C;
      }

      #outer-box {
        margin: 0px;
        padding: 16px;
        background-color: #F4F4F6;
        border: 1px solid #D7D7DD;
      }

      #input {
        font-family: 'JetBrains Mono', monospace;
        font-size: 16px;
        font-weight: 400;
        color: #0B0B0C;
        background-color: #FFFFFF;
        border: 1px solid #D7D7DD;
        padding: 12px 16px;
        margin-bottom: 16px;
        border-radius: 0px;
      }

      #inner-box {
        margin: 0px;
        background-color: transparent;
      }

      #scroll {
        border: 1px solid #D7D7DD;
        margin: 0px;
        background-color: transparent;
      }

      #entry {
        padding: 8px 12px;
        margin: 2px 0px;
        background-color: transparent;
        border: 1px solid transparent;
      }

      #selected {
        color: #0B0B0C;
      }

      #selected #text {
        color: #0B0B0C;
        font-weight: 700;
      }

      #text {
        margin: 0px;
        padding: 0px 8px;
        color: #48484A;
      }
		'';
	};

}
