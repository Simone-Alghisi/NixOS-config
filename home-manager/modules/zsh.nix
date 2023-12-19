{ config, pkgs, ... }:

{
  # zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autocd = true;

    initExtra = ''
      pythonify() {
        echo "use flake" > .envrc
        direnv allow
        nix flake init -t my-templates#python
        ${pkgs.neovim}/bin/nvim .
      }

      flakify() {
        echo "use flake" > .envrc
        direnv allow
        touch flake.nix
        ${pkgs.neovim}/bin/nvim .
      }
    '';

    localVariables = {

    };

    shellAliases = {
      ovhai = "${pkgs.steam-run}/bin/steam-run ${config.home.homeDirectory}/.local/bin/ovhai/./ovhai";
    };

    oh-my-zsh = {
      enable = true;
      # complete list at https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "gitfast"
        "python"
        "man"
        "fzf"
        "command-not-found"
        "colored-man-pages"
      ];
      # complete list at https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
      theme = "agnoster";
    };
  };

  # fzf
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
