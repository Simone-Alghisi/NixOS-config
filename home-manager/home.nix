{ pkgs, inputs, system, ...}:

{
	imports = [
		./modules/home.nix
		./modules/packages.nix
		./modules/git.nix
		./modules/vscode.nix
		./modules/java.nix
		./modules/zsh.nix
		./modules/vim.nix
		./modules/autostart.nix
		./modules/systemd.nix
	];
}
