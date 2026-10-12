{ pkgs, ... }: {
	home.username = "xiaoya";
	home.homeDirectory = "/home/xiaoya";
	home.stateVersion = "26.05";

	home.packages = with pkgs; [
		google-chrome
		wpsoffice
		prismlauncher
	];
}
