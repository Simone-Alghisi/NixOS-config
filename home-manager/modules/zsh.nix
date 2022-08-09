{ config, pkgs, ... }:

{
	# zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    enableCompletion = true;
    autocd = true;
    initExtra = ''
      pythonify() {
        echo "use flake" > .envrc
        direnv allow
        nix flake init -t my-templates#python
        ${pkgs.neovim}/bin/nvim .
      }
    '';
    localVariables = {

    };
    oh-my-zsh = {
      enable = true;
      # complete list at https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [ "git" "python" "man" "fzf" "command-not-found"];
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