{ config, pkgs, ...}:

{
	# To check the current gnome configuration you can run
	# `dconf dump / > dconf.settings` and look at the generated
	# file
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
			"org/gnome/settings-daemon/plugins/media-keys" = {
				"area-screenshot-clip"=["<Shift><Super>s"];
				"custom-keybindings"=["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
			};
			"org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
				"binding"="<Super>t";
				"command"="kgx";
				"name"="Terminal";
			};
			"org/gnome/settings-daemon/plugins/color" = {
				"night-light-enabled"=true;
			};
		};
	};

	home.file.".bg.jpg" = {
		source = ../assets/images/bg.jpg;
	};

	# If you want to test the value for a certain setting,
	# you can also rely on dconf-editor
	home.packages = [pkgs.gnome.dconf-editor];
}
