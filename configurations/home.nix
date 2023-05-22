{ config, pkgs, ... }:

{
  home.username = "sirbubbls";
  home.homeDirectory = "/home/sirbubbls";

  home.packages = with pkgs; [
    ripgrep
    zk
    gcc
    exa
    nodejs
    fzf
    gcc
    cowsay
    fd
    file
    thefuck
    zsh-syntax-highlighting
    unzip
    progress
    python310
    python310Packages.pip
    python310Packages.protobuf
    # Kubernetes Tools
    kubectx
    kubectl
    kubelogin
    kubernetes-helm
  ];
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases = {
      cl = "clear";
      ls = "exa";
    };
    localVariables = {
      EDITOR = "nvim";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "b4b4r07/enhancd"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
    initExtra = ''
      ${builtins.readFile ./p10k.zsh}
    '';
    enableCompletion = true;
    enableAutosuggestions = true;
  };
  programs.git = {
    enable = true;
    userName = "Lucas Sas Brunschier";
    userEmail = "lucassas@live.de";
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
    secureSocket = false;
    plugins = with pkgs.tmuxPlugins; [
      yank
      sensible
      nord
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      setw -g pane-base-index 1
      set -g mouse on
      set -g base-index 1
      bind e select-pane -U
      bind n select-pane -D
      bind h select-pane -L
      bind i select-pane -R
      bind v split-window -h
      bind s split-window -v
      bind k kill-pane
    '';
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
      extraConfig = ''
        ${builtins.readFile ./nvim/init.vim}
      '';
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/init.lua}
      '';
    };
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  }
