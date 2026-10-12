{
	description = "Pepi's NixOS config";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs,nixos-hardware, home-manager, ... }@inputs: {
		nixosConfigurations = {
			turtle = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./common.nix
					./hosts/desktop

					nixos-hardware.nixosModules.gigabyte-b550
					nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-gpu-amd

					home-manager.nixosModules.home-manager {
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;

						home-manager.users.pepi = import ./home/pepi.nix;
						home-manager.users.xiaoya = import ./home/xiaoya.nix;
					}
				];
			};
		};
	};
}
