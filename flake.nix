{
  description = "My NixOS system config.";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	  
	  home-manager = {
		  url = "github:nix-community/home-manager/release-25.11";
		  inputs.nixpkgs.follows = "nixpkgs";
	  };

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
      url = "github:imiric/qml-niri/main";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
        # to have it up-to-date or simply don't specify the nixpkgs input
        # nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    claude-code.url = "github:sadjow/claude-code-nix";
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, quickshell, qml-niri, zen-browser, claude-code, ... }@inputs: {
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
          inherit system;

          modules = [
            ./hosts/mycotoxin
            ./modules/system.nix

            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.overlays = [
                claude-code.overlays.default
              ];
            }

	          home-manager.nixosModules.home-manager {
		          home-manager.useGlobalPkgs = true;
		          home-manager.useUserPackages = true;
		          home-manager.backupFileExtension = "backup";

              home-manager.extraSpecialArgs = { inherit pkgs-unstable quickshell zen-browser ; };
              
		          home-manager.users.noelle = {
                imports = [
                  ./users/noelle/home.nix
                  zen-browser.homeModules.beta
                ];
              };
	          }
	          # { _module.args = { inherit inputs; };}
          ];
        };

      trantor = let
        username = "noelle";
        system = "x86_64-linux";
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      in
        nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/trantor
            ./modules/system.nix

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { inherit pkgs-unstable quickshell ; };
              home-manager.users.noelle = import ./users/noelle/home.nix;
            }
          ];
        };
    };
  #   nixosConfigurations.mycotoxin = nixpkgs.lib.nixosSystem {
  #     system = "x86_64-linux";
  #     modules = [
        
  #     ];
  };
}
