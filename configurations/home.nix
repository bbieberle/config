{ config, pkgs, ... }:

{
  home.username = "sirbubbls";
  home.homeDirectory = "/home/sirbubbls";

  home.packages = with pkgs; [
    ripgrep
    zk
    gcc
    exa
    fzf
    cowsay
    file
    thefuck
    zsh-syntax-highlighting
    unzip
    kubectl
  ];

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  programs.starship = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      cl = "clear";
    };
    zplug = {
      enable = true;
      #plugins = [
        #{
          #name = "zsh-nix-shell";
          #file = "nix-shell.plugin.zsh";
          #src = pkgs.fetchFromGitHub {
            #owner = "chisui";
            #repo = "zsh-nix-shell";
            #rev = "v0.5.0";
            #sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          #};
        #}
      #];
    };
    enableCompletion = true;
    enableAutosuggestions = true;
  };
  programs.git = {
    enable = true;
    userName = "Lucas Sas Brunschier";
    userEmail = "lucas.sas-brunschier@efs-techhub.com";
    extraConfig = {
      rebase = {
        autostash = true;
      };
      color = {
        ui = true;
      };
      pull = {
        rebase = true;
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
    ];
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = dracula;
        extraConfig = ''
          				set -g @dracula-show-battery false
          				set -g @dracula-show-powerline true
          				set -g @dracula-refresh-rate 10
          			'';
      }
      sensible
      yank
      {
        plugin = dracula;
        extraConfig = ''
          				set -g @dracula-show-battery false
          				set -g @dracula-show-powerline true
          				set -g @dracula-refresh-rate 10
          			'';
      }
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set -g mouse on
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
        p.c
        p.yaml
        p.rust
        p.python
      ]))
    ];
  };
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
