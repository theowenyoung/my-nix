{
  description = "Starter Configuration for NixOS and MacOS";

  inputs = {
        nixpkgs.url = "github:dustinlyons/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-webextfixed.url = "github:wingdeans/nixpkgs/web-ext-node-env";
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "git+ssh://git@github.com/theowenyoung/private.git"; # Change this!
      flake = false;
    };
  };
  outputs = { self, darwin, home-manager, nixpkgs, nixpkgs-darwin,disko, agenix, secrets ,nixpkgs-webextfixed} @inputs:
    let
      user = "green";
                name = "Owen Young";
                email  = "theowenyoung@gmail.com";
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "x86_64-darwin" "aarch64-darwin" ];
      forAllLinuxSystems = f: nixpkgs.lib.genAttrs linuxSystems (system: f system);
      forAllDarwinSystems = f: nixpkgs.lib.genAttrs darwinSystems (system: f system);
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) (system: f system);
      devShell = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = with pkgs; mkShell {
            nativeBuildInputs = with pkgs; [ bashInteractive git age ];
            shellHook = with pkgs; ''
              export EDITOR=vim
            '';
          };
        };
    in
    {
      devShells = forAllSystems devShell;
      darwinConfigurations =
        {
          "OwendeMacBook-Pro" = darwin.lib.darwinSystem
            (
              let
                user = "green";
                system = "x86_64-darwin";
              in
              {
                system = system;
                specialArgs = { inherit inputs user name email system nixpkgs-webextfixed; };
                modules = [
                  home-manager.darwinModules.home-manager
                  ./darwin
                ];
              }
            );
        };
      nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (system: nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = inputs;
        modules = [
          disko.nixosModules.disko
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./nixos/home-manager.nix;
          }
          ./nixos
        ];
      });
      formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
    };
}
