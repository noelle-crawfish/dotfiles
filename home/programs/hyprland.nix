{ config, pkgs, ... }:

{
  # Cursor theme configuration
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Adwaita";  
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitor configuration
      monitor = [
        ",preferred,auto,1"  # Auto-detect all monitors with scale 1
      ];

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      # Input configuration
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:win_space_toggle";
        kb_rules = "";

        follow_mouse = 2;
        
        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      # General window management
      general = {
        gaps_in = 1;
        gaps_out = 3;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration
      decoration = {
        rounding = 1;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };

        # drop_shadow = true;
        # shadow_range = 4;
        # shadow_render_power = 3;
        # "col.shadow" = "rgba(1a1a1aee)";
      };

      # Animations
      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Layout configuration
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Gestures
      gestures = {
        workspace_swipe = true;
      };

      # Miscellaneous
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
      };
      
      # Cursor settings
      cursor = {
        enable_hyprcursor = false;
      };

      # Key bindings
      "$mainMod" = "SUPER";

      bind = [
        # Application shortcuts
        "$mainMod, RETURN, exec, kitty"
        "$mainMod, Q, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, dolphin"
        "$mainMod, V, togglefloating"
        "$mainMod, bracketRight, exec, wofi --show drun"
        "$mainMod, P, pseudo" # dwindle
        "$mainMod, O, exec, emacs"

        # Move focus with vim keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Swap windows with vim keys
        "$mainMod SHIFT, h, swapwindow, l"
        "$mainMod SHIFT, l, swapwindow, r"
        "$mainMod SHIFT, k, swapwindow, u"
        "$mainMod SHIFT, j, swapwindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Special workspaces
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, A, togglespecialworkspace, spotify"
        "$mainMod SHIFT, A, movetoworkspace, special:spotify"

        # Scroll through existing workspaces with mainMod + Tab
        "$mainMod, TAB, workspace, e+1"
        "$mainMod SHIFT, TAB, workspace, e-1"
        
        # Fullscreen
        "$mainMod, F, fullscreen"
        
        # Screenshots
        ", PRINT, exec, hyprshot -m region"
        
        # Media keys
        ", XF86AudioMute, exec, amixer set Master toggle"
        ", XF86AudioRaiseVolume, exec, amixer -q sset Master 5%+"
        ", XF86AudioLowerVolume, exec, amixer -q sset Master 5%-"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      # windowrule = [
      #   "pseudo"
      # ];
      
      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
      ];

      # Startup applications
      exec-once = [
        "discord & spotify"
      ];

      exec = [
        "pkill hyprpaper; hyprpaper"  # Kill any existing hyprpaper and restart
      ];
    };
  };

  # Configure hyprpaper for wallpapers
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [
        "~/Pictures/wallpapers/scientists.png"  # Change this to your wallpaper path
      ];

      wallpaper = [
        ",~/Pictures/wallpapers/scientists.png" # Apply to all monitors
      ];
    };
  };
}
