{ pkgs, inputs, system, ...}:

{
	imports = [
		./modules/packages.nix
		./modules/git.nix
		./modules/vscode.nix
		./modules/java.nix
		./modules/zsh.nix
		./modules/vim.nix
	];
}
