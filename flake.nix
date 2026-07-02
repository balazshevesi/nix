{
  description = "Balazs' reproducible macOS nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # paneru = {
    #   url = "github:karinushka/paneru";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nix-darwin, home-manager, sops-nix, stylix, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macbook-air-m2
    darwinConfigurations."macbook-air-m2" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        stylix.darwinModules.stylix
        sops-nix.darwinModules.sops
        ./hosts/macbook-air-m2.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # home-manager.sharedModules = [
          #   inputs.paneru.homeModules.paneru
          # ];
          home-manager.users.balazshevesi = import ./users/balazshevesi.nix;
        }
      ];
    };
  };
}
