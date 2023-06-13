{ config, pkgs, ... }:
{
  home.username = "deddo";
  home.homeDirectory = "/home/deddo";
#  home.file.".config//alacritty.yml".source = ./config/alacritty.yml;
#  home.file.".config/kitty/kitty.conf".source = ./config/kitty.conf;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    ripgrep
    exa
    fzf
    zsh-syntax-highlighting
    unzip
    progress
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
     
    # dev tools
    vscode    

    # Kubernetes Tools
    k9s
    kubectl
    kubernetes-helm
    # Build utilities
    
  ];
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;

  programs.direnv.enable = false;
  programs.direnv.nix-direnv = {
    enable = false;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa";
    };
    localVariables = {
      EDITOR = "nano";
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
    userName = "Benedikt Bieberle";
    userEmail = "git@sharkmails.net";
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
  
}
