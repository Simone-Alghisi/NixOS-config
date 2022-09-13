{ config, pkgs, ...}:

{
	dconf = {
		enable = true;
		settings = {
			"org/gnome/desktop/background" = {
				"picture-uri" = "${config.home.homeDirectory}/.bg.jpg";
				"picture-uri-dark" = "${config.home.homeDirectory}/.bg.jpg";
			};
			"org/gnome/desktop/interface" = {
				"color-scheme"="prefer-dark";
			};
			"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
				"binding"="<Super>t";
				"command"="kgx";
				"name"="Terminal";
			};
		};
	};

	home.file.".bg.jpg" = {
		source = ../assets/images/bg.jpg;
	};
}
