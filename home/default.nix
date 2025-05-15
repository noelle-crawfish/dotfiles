{ config, pkgs, ... }:
{
	home.username = "noelle";
	home.homeDirectory = "/home/noelle";

	home.packages = with pkgs; [
		neofetch
	];

	programs.zsh = {
		enable = true;

		shellAliases = {
			hy = "history";
		};
	};
	
	home.stateVersion = "24.11";
	
	programs.home-manager.enable = true;
}
