{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "marc";
  home.homeDirectory = "/home/marc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  wayland.windowManager.hyprland.enable = true;


  programs.waybar.package = pkgs.waybar.overrideAttrs (oa: {
    mesonFlags = (oa.mesonFlags or  []) ++ [ "-Dexperimental=true" ];
    patches = (oa.patches or []) ++ [
      (pkgs.fetchpatch {
        name = "fix waybar hyprctl";
        url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
        sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
      })
    ];
  });

  wayland.windowManager.hyprland.extraConfig = ''
    ########################################################################################
    AUTOGENERATED HYPR CONFIG.
    PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
    OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
    ########################################################################################
    
    $mod = SUPER
    #
    # bind = $mod, F, exec, firefox
    # bind = , Print, exec, grimblast copy area
    #
    # # workspaces
    # # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}


    
    #
    # Please note not all available settings / options are set here.
    # For a full list, see the wiki (basic and advanced configuring)
    #
    
    autogenerated=0 # remove this line to get rid of the warning on top.
    
    # monitor=,1920x1080@60,0x0,1
    # monitor=eDP-1,1920x1080@60,320x1440,1
    monitor=eDP-1,1920x1080@60,320x1440,1
    monitor=DP-1,2560x1440@60,0x0,1
    
    # wsbind=1,eDP-1
    # wsbind=2,eDP-1
    # wsbind=3,eDP-1
    # wsbind=4,eDP-1
    # wsbind=5,eDP-1
    # wsbind=6,DP-1
    # wsbind=7,DP-1
    # wsbind=8,DP-1
    # wsbind=9,DP-1
    # wsbind=0,DP-1
    
    input {
        kb_layout=fr
        kb_variant=us
        # kb_model=
        kb_options=caps:escape
        # kb_rules=
    
        follow_mouse=1
        natural_scroll=true
        touchpad {
            natural_scroll=true
            disable_while_typing=false
            middle_button_emulation=true
            tap-to-click=true
        }
    }

    font {
        normal {
            family=nerdfonts
            style=Regular
        }
    }
    
    general {
        sensitivity=1 # for mouse cursor
        # main_mod=SUPER
    
        gaps_in=5
        gaps_out=10
        # border_size=2
        border_size=0
        col.active_border=0x66ee1111
        col.inactive_border=0x66333333
    
        apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
    
        # damage_tracking=full # leave it on full unless you hate your GPU and want to make it suffer
        layout=dwindle
    }
    
    decoration {
        rounding=5
        # blur=1
        # blur_size=3 # minimum 1
        # blur_passes=1 # minimum 1, more passes = more resource intensive.
        # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
        # if you want heavy blur, you need to up the blur_passes.
        # the more passes, the more you can up the blur_size without noticing artifacts.
        shadow_render_power=2
        shadow_range=4
        # shadow_range=4
        drop_shadow=true
    }
    animations {
        enabled=1
        # bezier=overshot,0.05,0.9,0.1,1.1
        bezier=overshot,0.13,0.99,0.29,1.1
        animation=windows,1,4,overshot,slide
        animation=border,1,10,default
        animation=fade,1,10,default
        # animation=workspaces,1,6,overshot,slide
        animation=workspaces,1,6,overshot,slidevert
    }
    # animations {
    #     enabled=1
    #     animation=windows,1,7,default
    #     # animation=borders,1,10,default
    #     # animation=fadein,1,10,default
    #     animation=workspaces,1,6,default
    # }
    
    dwindle {
        pseudotile=0 # enable pseudotiling on dwindle
    }
    
    
    gestures {
        workspace_swipe=true
        # workspace_swipe_fingers=3
    }
    
    misc {
        disable_hyprland_logo=true
    }
    
    # example window rules
    # for windows named/classed as abc and xyz
    #windowrule=move 69 420,abc
    #windowrule=size 420 69,abc
    #windowrule=tile,xyz
    #windowrule=float,abc
    #windowrule=pseudo,abc
    #windowrule=monitor 0,xyz
    
    # windowrule=tile,title:^(Spotify)$ # spotify does not work
    windowrule=float,^(blueberry.py)$
    windowrule=size 40% 85%,^(blueberry.py)$
    windowrule=center,^(blueberry.py)$
    windowrule=size 50% 50%,^(wdisplays)$
    windowrule=float,^(wdisplays)$
    windowrule=center,^(wdisplays)$
    windowrule=workspace 1,^(Alacritty)$
    # windowrule=float,^(Alacritty)$
    # windowrule=size 50% 95%,^(Alacritty)$
    windowrule=center,^(Alacritty)$
    windowrule=workspace 2,^(Firefox)$
    windowrule=workspace 3,title:^(Spotify)$
    windowrule=workspace 4,title:^(WebCord)$
    windowrule=workspace 4,title:^(Discord)$
    windowrule=workspace 5,title:^(Caprine)$
    windowrule=workspace 6,title:^(Mailspring)$
    windowrule=nofullscreenrequest,title:^(Mailspring)$
    windowrule=nofullscreenrequest,title:^(Signal)$
    windowrule=workspace 6,title:^(Geary)$
    
    # workspace=name:myworkspace,gapsin:0,gapsout:
    workspace = 1, name:coding, rounding:true, decorate:false, gapsin:5, gapsout:10, border:true, decorate:true, monitor:eDP-1
    workspace = 2, name:browser, monitor:eDP-1
    workspace = 3, name:music, monitor:eDP-1
    
    
    # bind=SUPER,U,layoutmsg,preselect 1
    # bind=SUPER,Y,layoutmsg,swapwithmaster master
    
    # some nice mouse binds
    bindm=SUPER,mouse:272,movewindow
    bindm=SUPER,mouse:273,resizewindow
    
    # example binds
    # bind=SUPER,D,exec,rofi -show run
    bind=SUPER,RETURN,exec,alacritty
    bind=SUPER,C,killactive,
    bind=SUPERSHIFT,C,exec,xdotool getwindowfocus windowkill
    bind=SUPERSHIFT,Q,exit,
    bind=SUPER,M,fullscreen
    bind=SUPER,S,exec,spotify
    bind=SUPER,V,togglefloating,
    bind=SUPER,D,exec,wofi --insensitive --show drun -o DP-3 --allow-images
    bind=SUPER,P,pseudo,
    bind=CTRLSHIFT,L,exec,.local/bin/lock
    bind=ALT,L,exec,nautilus
    bind=ALT,F,exec,firefox-nightly
    bind=SUPER,B,exec,gnome-control-center bluetooth
    bind=SUPER,W,exec,rofi-connman
    # bind=ALT,B,exec,~/.local/bin/restartbluetooth
    # bind=ALT,W,exec,.local/bin/restartwallpaper
    bind=ALT,W,exec,systemctl --user restart wpaperd
    bind=SUPERSHIFT,B,exec,systemctl --user restart waybar
    bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
    bind=,XF86AudioLowerVolume,exec,pamixer -d 5
    bind=,XF86AudioMute,exec,pamixer -t
    bind,0x1008FF02,exec pamixer -t
    bind,XF86BrightnessDown,exec pamixer -t
    bind=,XF86MonBrightnessUp,exec,brightnessctl s 1%+
    bind=,XF86MonBrightnessDown,exec,brightnessctl s 1%-
    bind=,XF86MonBrightnessDown,exec,brightnessctl s 1%-
    bind=,Print,exec,.local/bin/screenshot
    bind=SHIFT,Print,exec,.local/bin/screenshotandedit
    bind=CTRL,Print,exec,alacritty -e ~/.local/bin/record
    bind,Caps_Lock,exec,xdotool key Escape
    # bind=ALT,w,exec,wppen -n
    # bind=ALT,w,exec,systemctl --user restart wpaperd
    
    # spotify
    bind=ALT,a,exec,.local/bin/spenv like
    bind=SHIFTALT,d,exec,.local/bin/spenv seek +10
    bind=SHIFTALT,s,exec,.local/bin/spenv seek -10
    bind=ALT,K,exec,playerctl -p spotify play-pause
    bind=ALT,D,exec,playerctl -p spotify next
    bind=ALT,S,exec,playerctl -p spotify previous
    # bind=ALT,K,exec,.local/bin/spotifycli --playpause
    # bind=ALT,d,exec,.local/bin/spotifycli --next
    # bind=ALT,s,exec,.local/bin/spotifycli --prev
    # bind=ALT,d,exec,.local/bin/spenv next
    # bind=ALT,s,exec,.local/bin/spenv previous
    bind=SHIFT,XF86AudioRaiseVolume,exec,.local/bin/spenv volume +15
    bind=SHIFT,XF86AudioLowerVolume,exec,.local/bin/spenv volume -15
    
    bind=ALT,R,submap,resize # will switch to a submap called resize
    submap=resize # will start a submap called "resize"
    bind=,h,resizeactive,-10 0
    bind=,l,resizeactive,10 0
    bind=,k,resizeactive,0 10
    bind=,j,resizeactive,0 -10
    bind=,escape,submap,reset # use reset to go back to the global submap
    submap=reset
    # bind=SUPERSHIFT,h,resizeactive,10 0
    # bind=SUPERSHIFT,l,resizeactive,-10 0
    # bind=SUPERSHIFT,j,resizeactive,0 -10
    # bind=SUPERSHIFT,k,resizeactive,0 10
    
    bind=SUPER,l,movefocus,l
    bind=SUPER,h,movefocus,r
    bind=SUPER,k,movefocus,u
    bind=SUPER,j,movefocus,d
    
    bind=SUPER,1,workspace,1
    bind=SUPER,2,workspace,2
    bind=SUPER,3,workspace,3
    bind=SUPER,4,workspace,4
    bind=SUPER,5,workspace,5
    bind=SUPER,6,workspace,6
    bind=SUPER,7,workspace,7
    bind=SUPER,8,workspace,8
    bind=SUPER,9,workspace,9
    bind=SUPER,0,workspace,10
    
    bind=ALT,1,movetoworkspace,1
    bind=ALT,2,movetoworkspace,2
    bind=ALT,3,movetoworkspace,3
    bind=ALT,4,movetoworkspace,4
    bind=ALT,5,movetoworkspace,5
    bind=ALT,6,movetoworkspace,6
    bind=ALT,7,movetoworkspace,7
    bind=ALT,8,movetoworkspace,8
    bind=ALT,9,movetoworkspace,9
    bind=ALT,0,movetoworkspace,10
    
    bind=SUPER,mouse_down,workspace,e+1
    bind=SUPER,mouse_up,workspace,e-1
    
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once=~/.local/bin/poststartx
    exec-once=~/.local/bin/restartbluetooth
    # exec-once=hyprctl --batch "keyword input:kb_layout fr ; keyword input:kb_variant us"

    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

    # ...
  '';

  # home.docker.containers = {
  #   test = {
  #     name = "test";
  #     image = "nginx:latest";
  #     ports = ["80:80"];
  #     volumes = ["/srv:/srv"];
  #   };
  # };

  services.gpg-agent = {                          
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };


  # services.autossh = {
  #   enable = true;
  #   description = "Autossh";
  #   script = "${pkgs.autossh}/bin/autossh";
  #   scriptArgs = [ "/path/to/your/script.sh" ];
  #   environment = {
  #     "VAR_NAME" = "value";
  #   };
  # };

  systemd.user.services = {
    waybar = {
        Unit.Description = "Waybar";
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };
      Install = { WantedBy = [ "default.target" ]; };
    };
    swww = {
      Unit = {
        Description = "Swww";
        # StartLimitBurst = "10";
        # StartLimitIntervalSec = "5";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.swww}/bin/swww init";
        ExecStop = "${pkgs.swww}/bin/swww kill";
        Restart = "on-failure";
      };
      Install = { WantedBy = [ "default.target" "waybar.target" ]; };
    };
    autossh = {
      Unit = { 
        Description = "Connect to my tower remotely.";
        StartLimitBurst = "10";
        StartLimitIntervalSec = "5";
      };
      Service = {
        Type = "exec";
        ExecStart = ''
          ${pkgs.autossh}/bin/autossh -M 0 \
          -o ServerAliveInterval=300 \
          -o ServerAliveCountMax=10 \
          -o PubkeyAuthentication=yes \
          -o PasswordAuthentication=no \
          -NR localhost:42071:localhost:22 \
          -p 42069 \
          -i ~/.ssh/id_rsa \
          marc@207.180.235.56
          '';
        Restart = "on-failure";
      };
      Install = { WantedBy = [ "network.target" ]; };
      # enable = true;
      # description = "";
      # unitConfig = {
      #     Type = "simple";
      # };
      # serviceConfig = {
      #     ExecStart = "${pkgs.autossh}/bin/autossh -M 0 -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -o PubkeyAuthentication=yes -o PasswordAuthentication=no -NR localhost:42071:localhost:22 -p 42069 -i ~/.ssh/id_rsa marc@207.180.235.56";
      # };
      # wantedBy = [ "multi-user.target" ];
    };
    autossh2 = {
      Unit = { 
        Description = "Connect to my tower remotely.";
        StartLimitBurst = "10";
        StartLimitIntervalSec = "5";
      };
      Service = {
        Type = "exec";
        ExecStart = ''
          ${pkgs.autossh}/bin/autossh -M 0 \
          -o ServerAliveInterval=300 \
          -o ServerAliveCountMax=10 \
          -o PubkeyAuthentication=yes \
          -o PasswordAuthentication=no \
          -NR localhost:42072:localhost:22 \
          -p 42069 \
          -i ~/.ssh/id_rsa \
          marc@207.180.235.56
          '';
        Restart = "on-failure";
      };
      Install = { WantedBy = [ "network.target" ]; };
      # enable = true;
      # description = "";
      # unitConfig = {
      #     Type = "simple";
      # };
      # serviceConfig = {
      #     ExecStart = "${pkgs.autossh}/bin/autossh -M 0 -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -o PubkeyAuthentication=yes -o PasswordAuthentication=no -NR localhost:42071:localhost:22 -p 42069 -i ~/.ssh/id_rsa marc@207.180.235.56";
      # };
      # wantedBy = [ "multi-user.target" ];
    };
  };

    systemd.user.timers = {
      autossh = {
        Unit.Description = "Restart autossh tunnel just to be sure";
        Timer = {
          Unit = "autossh";
          # OnBootSec = "1m";
          OnUnitActiveSec = "1m";
          # OnCalendar = "*-*-* 4:00:00";
          # OnCalendar = "Hourly";
          Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
      };
      autossh2 = {
        Unit.Description = "Restart autossh tunnel just to be sure";
        Timer = {
          Unit = "autossh2";
          # OnBootSec = "1m";
          OnUnitActiveSec = "1m";
          # OnCalendar = "*-*-* 4:00:00";
          # OnCalendar = "Hourly";
          Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };


  # builtins.fetchGit {
  #   url = "git@github.com:marcpartensky/wallpapers";
  #   rev = "e7e3f89eab78390cce674273cfe2f4f110ccdfeb";
  # };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/marc/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages= with pkgs; [
    neofetch
    doas-sudo-shim
    pipewire
    wireplumber
    wdisplays
    mako
    wl-clipboard
    pavucontrol
    bluetuith
    exa
    bat
    htop
    fzf
    stow
    neovim
    autossh
    zsh
    nmap
    helm
    tmate
    docker
    docker-compose
    podman
    silver-searcher
    cloudflared
    doas
    k3s
    # alacritty
    wayvnc
    wofi
    firefox
    wlsunset
    waybar
    spotify-tui
    ncspot
    hyprpaper
    acpi
    swaylock
    tmux
    glib
    pcmanfm
    gvfs
    glpaper
    swww
    mcfly
    kodi
    tldr
    xfce.thunar
    ydotool
    # pkgs.hello
    signal-desktop
    httpie
    postgresql
    pamixer
    ncdu
    dig
    wget
    nodejs
    poetry
    # gnome3.gvfs
    gnome3.nautilus
    gnome.nautilus
    gparted
    tor-browser-bundle-bin
    zathura
    thunderbird

    ### Proprietary
    spotify
    discord

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "spotify"
      "discord"
    ];

}
