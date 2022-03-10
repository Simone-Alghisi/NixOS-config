{ config, pkgs, ...}:

{
	programs.vscode = {
		enable = true;

		extensions = with pkgs.vscode-extensions; [
			bbenoist.nix
			ms-python.python
			ms-python.vscode-pylance
			ms-toolsai.jupyter
			arrterian.nix-env-selector
			dracula-theme.theme-dracula
		];
		
		keybindings = [
			# keybind example
			# {
			# 	key = "ctrl+c";
			# 	command = "editor.action.clipboardCopyAction";
			# 	when = "textInputFocus";
			# 	args = "";
			# }
		];
		userSettings = {
			"window.zoomLevel" = 1;
			"terminal.integrated.fontFamily" = "\"Droid Sans Mono for Powerline\"";
			"workbench.colorTheme" = "Dracula";
			"python.languageServer" = "Pylance";
			"editor.tabSize" = 2;
		};
	};
}