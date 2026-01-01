{
  description = "My NixOS system config.";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	  
	  home-manager = {
		  url = "github:nix-community/home-manager/release-25.05";
		  inputs.nixpkgs.follows = "nixpkgs";
	  };

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, quickshell, ... }@inputs: {
    nixosConfigurations = {
      mycotoxin = let
        username = "noelle";

        system = "x86_64-linux";

        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      in 
        nixpkgs.lib.nixosSystem {

          modules = [
            ./hosts/mycotoxin
            ./modules/system.nix
	          
	          home-manager.nixosModules.home-manager {
		          home-manager.useGlobalPkgs = true;
		          home-manager.useUserPackages = true;
		          home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = { inherit pkgs-unstable quickshell ; };
              
		          home-manager.users.noelle = import ./users/noelle/home.nix;
	          }
	          # { _module.args = { inherit inputs; };}
          ];
        };
    };
  #   nixosConfigurations.mycotoxin = nixpkgs.lib.nixosSystem {
  #     system = "x86_64-linux";
  #     modules = [
        
  #     ];
  };
}
