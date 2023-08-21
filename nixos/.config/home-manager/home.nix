{ config, pkgs, ... }:

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
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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

  systemd.user.services.autossh = {
    Unit = { 
      Description = "Autossh tunnel";
    };
    Service = {
      Type = "exec";
      ExecStart = "${pkgs.autossh}/bin/autossh -M 0 -o ServerAliveInterval=300 -o ServerAliveCountMax=10 -o PubkeyAuthentication=yes -o PasswordAuthentication=no -NR localhost:42071:localhost:22 -p 42069 -i ~/.ssh/id_rsa marc@207.180.235.56";
      Restart = "on-failure";
    };
    Install = { WantedBy = [ "default.target" ]; };
    # enable = true;
    # description = "Connect to my tower remotely";
    # unitConfig = {
    #     Type = "simple";
    # };
    # serviceConfig = {
    #     ExecStart = "${pkgs.autossh}/bin/autossh -M 0 -o ServerAliveInterval=30 -o ServerAliveCountMax=3 -o PubkeyAuthentication=yes -o PasswordAuthentication=no -NR localhost:42071:localhost:22 -p 42069 -i ~/.ssh/id_rsa marc@207.180.235.56";
    # };
    # wantedBy = [ "multi-user.target" ];
  };





  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages= with pkgs; [
    htop
    fzf
    nmap
    neovim
    zsh
    helm
    tmate
    docker
    podman
    silver-searcher
    cloudflared
    doas
    # pkgs.hello

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

}
