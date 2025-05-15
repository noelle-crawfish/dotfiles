{
  description = "My NixOS system config.";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
	  
	  home-manager = {
		  url = "github:nix-community/home-manager/release-24.11"; 
		  inputs.nixpkgs.follows = "nixpkgs";
	  };
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      mycotoxin = let
        username = "noelle";
      in {
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/mycotoxin
            ./modules/system.nix
	          
	          home-manager.nixosModules.home-manager {
		          home-manager.useGlobalPkgs = true;
		          home-manager.useUserPackages = true;
		          home-manager.backupFileExtension = "backup";
              
		          home-manager.users.noelle = import ./users/noelle/home.nix;
	          }
	          { _module.args = { inherit inputs; };}
          ];
        };
      };
    }
  #   nixosConfigurations.mycotoxin = nixpkgs.lib.nixosSystem {
  #     system = "x86_64-linux";
  #     modules = [
        
  #     ];
  #   };
  };
}
