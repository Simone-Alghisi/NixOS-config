{ config, pkgs, ... }:

{
	# zsh
  programs.zsh.enable = true;
  
  # oh-my-zsh package
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "python" "man" ];
    theme = "agnoster";
  };
}