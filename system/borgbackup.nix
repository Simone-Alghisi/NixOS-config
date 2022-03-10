{ pkgs, config, ... }:

{
	services.borgbackup.jobs =
		# define general configurations
		let 
			# list of
			common_excludes = [
				".cache"
				"*/cache"
				"*/cache2"
				"*/GPUCache"
				"*/Cache"
				"*/Code Cache"
				"*/\$RECYCLE.BIN"
				"*/backups"
				"*/System\ Volume\ Information"
				"*/node_modules"
			];
			BorgJob = {path_to_repo, cmd}: rec {
				user = "root";
				repo = path_to_repo;
				exclude = map (x: "/home/alghisius" + "/" + x) (common_excludes);
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
				} // {
					paths = "/home/alghisius";
					extraCreateArgs = "--stats --checkpoint-interval 600 --list";
					postCreate = ''
						echo "started rclone at" ''$(date)
						/run/current-system/sw/bin/rclone --config='/home/alghisius/.config/rclone/rclone.conf' sync /home/alghisius/shared/backups remote:backups --progress
						echo "finished rclone at" ''$(date)
					'';
				};
			};
}