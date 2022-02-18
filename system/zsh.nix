{ config, pkgs, ... }:

{
	# zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };
  
  # oh-my-zsh package
  programs.zsh.ohMyZsh = {
    enable = true;
    # complete list at https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
    plugins = [ "git" "python" "man" ];
    # complete list at https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
    theme = "agnoster";
  };
}