{ pkgs, config, ... }:

{
	services.borgbackup.jobs =
		# define general configurations
		let 
			# list of
			common_excludes = [
				"\$RECYCLE.BIN"
				".Trash-1000"
				"System\ Volume\ Information"
				"Recovery"
				"Recovery.txt"
				"backups"
				"Screenshots"
				".git"
				".direnv"
				"**/*cache*"
				"**/*Cache*"
				"**/Service\ Worker/"
				"**/node_modules"
				"**/.git"
				"**/.direnv"
			];
			BorgJob = {path_to_repo, cmd}: {
				user = "root";
				repo = path_to_repo;
				compression = "auto,lzma";
				# timer set for all days at 11:00, see https://www.freedesktop.org/software/systemd/man/systemd.time.html
				startAt = "*-*-* 11:00:00";
				prune.keep = {
					daily = 4; # Keep all archive of last four days 
					weekly = 2; # Keep all archive of last two weeks
					monthly = 1; # Keep all archive of last month
				};
				encryption = {
					mode = "repokey";
					passCommand = cmd;
				};
			};
		in
			{
				drive = BorgJob {
					path_to_repo = "/home/alghisius/shared/backups"; 
					cmd = "cat /home/alghisius/.config/borg/alghisius/passphrase1";
				} // rec {
					paths = [
						"/home/alghisius/Documents"
						"/home/alghisius/Music"
						"/home/alghisius/NixOS-config"
						"/home/alghisius/Pictures"
						"/home/alghisius/shared"
						"/home/alghisius/.config"
						"/home/alghisius/.ssh"

					];
					exclude = builtins.concatLists (
						map (x: 
							map (y: 
								x + "/" + y
							) (common_excludes)
						) (paths)
					);
					extraCreateArgs = "--stats --checkpoint-interval 600 --list";
					postCreate = ''
						${pkgs.rclone}/bin/rclone --config='/home/alghisius/.config/rclone/rclone.conf' sync /home/alghisius/shared/backups remote:backups --progress
					'';
				};
			};
}
