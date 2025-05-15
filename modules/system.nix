{ pkgs, lib, ... }:
{
	# limit the number of config generations to keep
	boot.loader.systemd-boot.configurationLimit = 10;

	# weekly garbage collection of old configs
	nix.gc = {
		automatic = lib.mkDefault true;
		dates = lib.mkDefault "weekly";
		options = lib.mkDefault "--delete-older-than 7d";
	};

	# no clue what this does but has to be good right?
	nix.settings.auto-optimise-store = true;
}
		
