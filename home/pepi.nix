{ pkgs, config, lib, ...}: {
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
		spotify
		pulsemixer
	];

	wayland.windowManager.sway = {
		enable = true;
		config = {
			modifier = "Mod4";
			terminal = "${pkgs.foot}/bin/foot";
			menu = "${pkgs.wofi}/bin/wofi";
			bars = [{ command = "waybar"; }];
			startup = [
			{
				command = "${pkgs.swaybg}/bin/swaybg -c '#F4F4F6'";
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
				"${mod}+d" = "exec wofi --show drun";
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
}
