{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs?rev=08f22084e6085d19bcfb4be30d1ca76ecb96fe54";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgsUnstable, nixpkgs, home-manager } @attrs: {
    nixosConfigurations.fritiof-old-dell = nixpkgs.lib.nixosSystem rec {
      # pkgs = import nixpkgs {
      #   inherit system;
      #   config = { allowUnfree = true; };
      # };
      system = "x86_64-linux";
      modules = [ 
        ./computers/old-dell/configuration.nix
            ({ config, pkgs, options, ... }: { nix.registry.nixpkgs.flake = nixpkgs; })
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.fritiof = ./home.nix;
            home-manager.extraSpecialArgs = { 
              quickshell = nixpkgsUnstable.quickshell;
            };
          }
      ];
    };
  };
}
