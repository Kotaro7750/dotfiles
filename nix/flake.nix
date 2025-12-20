{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      mkHome = { name, system, hostModule }:
        let
          pkgs = import nixpkgs {
            inherit system; 
            config.allowUnfree = true;  # This is for installing GUI applications
          };
        in
        {
          ${name} = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./home-manager/common.nix
              hostModule
            ];
          };
        };
    in
    {
      homeConfigurations =
        (mkHome {
          name = "private-osx-arm";
          system = "aarch64-darwin";
          hostModule = ./home-manager/hosts/private-osx-arm.nix;
        });
    };
}
