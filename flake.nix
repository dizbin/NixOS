{
  description = "A very basic Diz flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
  };

  outputs = { self, nixpkgs, jovian, ... }: {
    nixosConfigurations.Cerberus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix 
	          jovian.nixosModules.default
      ];
    };
  };
}
