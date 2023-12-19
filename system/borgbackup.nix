{ pkgs, config, ... }:

{
	services.borgbackup.jobs =
		# define general configurations
		let
			# list of
			common_excludes = [
				"\$RECYCLE.BIN"
				".Trash-1000"
				"backups"
				"System\ Volume\ Information"
				"Recovery"
				"Recovery.txt"
				"Screenshots"
				".direnv"
				"**/.direnv"
				"**/*cache*"
				"**/*Cache*"
				"**/node_modules"
				"**/Service\ Worker/"
				"**/Trash"
			];
			BorgJob = {pathToRepo, cmd}: {
				user = "root";
				repo = pathToRepo;
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
					pathToRepo = "${home}/shared/backups";
					cmd = "cat ${home}/.config/borg/alghisius/passphrase1";
				} // rec {
					paths = [
						"${home}/.config"
						"${home}/.jupyter"
						"${home}/.local"
						"${home}/.mozilla"
						"${home}/.ssh"
						"${home}/.thunderbird"
						"${home}/.zotero"
						"${home}/Documents"
						"${home}/Music"
						"${home}/NixOS-config"
						"${home}/Pictures"
						"${home}/shared/Magistrale"
						"${home}/shared/obsidian"
						"${home}/shared/personal_documents"
						"${home}/shared/personal_page"
						"${home}/shared/PhD"
						"${home}/shared/Università"
					];
					exclude = builtins.concatLists (
						map (x:
							map (y:
								x + "/" + y
							) (common_excludes)
						) (paths)
					);
					preHook = ''
						# Workaround to borg returning exit code 2 for warnings
						${pkgs.coreutils}/bin/sleep 60
					'';
					extraCreateArgs = "--stats --checkpoint-interval 600 --list";
					extraPruneArgs = "--stats --list";
					postPrune = ''
						${pkgs.coreutils}/bin/echo "compacting archives"
						${pkgs.borgbackup}/bin/borg --progress compact --cleanup-commits ${home}/shared/backups
						${pkgs.coreutils}/bin/echo "running rclone"
						${pkgs.rclone}/bin/rclone --config='${home}/.config/rclone/rclone.conf' sync ${home}/shared/backups unitn:backups --progress
						${pkgs.rclone}/bin/rclone --config='${home}/.config/rclone/rclone.conf' sync ${home}/shared/backups personal:backups --progress
					'';
				};
			};
}
