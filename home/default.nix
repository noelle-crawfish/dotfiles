{ config, pkgs, pkgs-unstable, quickshell, ... }:
{
  imports = [
    ./programs/default.nix
  ];
	home.username = "noelle";
	home.homeDirectory = "/home/noelle";

	home.packages = with pkgs; [
	  discord
		zotero
    spotify
    foliate
	  darktable
    doxygen

    calibre
    digikam
	  inkscape

	  qemu
	  virt-manager
	  anki-bin

    aider-chat
    drawio
    gemini-cli
    libreoffice
    python312Packages.jupytext
    jupyter

    pkgs-unstable.signal-desktop
    qFlipper

    pavucontrol
    cudaPackages.nsight_systems

    quickshell.packages.${pkgs.system}.default

  # ]) ++ [

  blender
  gtest
  claude-code

		# qmk
    # qmk-udev-rules # the only relevant
    # qmk_hid
    # via
    # vial
	];

  xdg.configFile."niri/config.kdl".source = ./niri-config.kdl;

  xdg.configFile."quickshell/config.toml" = {
  text = ''
    # This section defines your status bar.
    [[bar]]
    position = "top"
    
    # --- Widgets ---
    # The widgets will be displayed in the order they are defined.

    # Displays your window manager's workspaces.
    [[bar.widgets]]
    widget = "workspaces"
    
    # A customizable clock.
    [[bar.widgets]]
    widget = "clock"
    format = "%a %b %d - %I:%M %p" # e.g., "Sun Oct 12 - 01:56 PM"
    
    # Shows your current CPU usage.
    [[bar.widgets]]
    widget = "cpu"
    format = "CPU: {percent_usage}%"

    # Shows your current RAM usage.
    [[bar.widgets]]
    widget = "memory"
    format = "MEM: {percent_used}%"
  '';
  };


  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  
	programs.zsh = {
		enable = true;

		shellAliases = {
			hy = "history";
		};

    initExtra = ''
      eval "$(direnv hook zsh)"
    '';  
	};
	
	home.stateVersion = "24.11";
	
	programs.home-manager.enable = true;
}
