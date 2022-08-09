{ pkgs, inputs, system, ...}:

{
	imports = [
		./modules/autostart.nix
		./modules/git.nix
		./modules/home.nix
		./modules/java.nix
		./modules/packages.nix
		./modules/registry.nix
		./modules/systemd.nix
		./modules/vim.nix
		./modules/vscode.nix
		./modules/zotero.nix
		./modules/zsh.nix
	];
}
