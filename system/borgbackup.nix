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
				# timer set for all days, see https://www.freedesktop.org/software/systemd/man/systemd.time.html
				startAt = "daily";
				prune.keep = {
					daily = 4; # Keep all archive of last four days
					weekly = 2; # Keep all archive of last two weeks
					monthly = 1; # Keep all archive of last month
				};
				persistentTimer = true;
				encryption = {
					mode = "repokey";
					passCommand = cmd;
				};
			};
			home = config.users.users.alghisius.home;
		in
			{
				drive = BorgJob {
					path_to_repo = "${home}/shared/backups";
					cmd = "cat ${home}/.config/borg/alghisius/passphrase1";
				} // rec {
					paths = [
						"${home}/Documents"
						"${home}/Music"
						"${home}/NixOS-config"
						"${home}/Pictures"
						"${home}/shared"
						"${home}/.config"
						"${home}/.ssh"
					];
					exclude = builtins.concatLists (
						map (x:
							map (y:
								x + "/" + y
							) (common_excludes)
						) (paths)
					);
					extraCreateArgs = "--stats --checkpoint-interval 600 --list";
					extraPruneArgs = "--stats --list";
					postPrune = ''
						echo "compacting archives"
						${pkgs.borgbackup}/bin/borg --progress compact --cleanup-commits ${home}/shared/backups
						echo "running rclone"
						${pkgs.rclone}/bin/rclone --config='${home}/.config/rclone/rclone.conf' sync ${home}/shared/backups unitn:backups --progress
						${pkgs.rclone}/bin/rclone --config='${home}/.config/rclone/rclone.conf' sync ${home}/shared/backups personal:backups --progress
					'';
				};
			};
}
