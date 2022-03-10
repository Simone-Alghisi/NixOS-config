{ config, pkgs, ...}:

{
	programs.git = {
		enable = true;
		userEmail = "alghisius.simone@gmail.com";
		userName = "Simone-Alghisi";
		extraConfig = {
			init = {
				defaultBranch = "master";
			};
		};
	};
}