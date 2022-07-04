{ config, pkgs, ...}:

{
    systemd.user = {

        timers = {
            clean-screenshots = {
                Unit = {
                    Description = "Run clean-screenshoots daily";
                };
                Timer = {
                    OnCalendar = "*-*-* 9:30:00";
                    Persistent = true;
                };
                Install = {
                    WantedBy = [ "timers.target" ];
                };
            };
        };

        services = {
            clean-screenshots = {
                Unit = {
                    Description = "Clean user screenshots folder";
                };
                Service = {
                    # systemd does not expand wildcards, while find can delete using -delete
                    # https://systemd-devel.freedesktop.narkive.com/f5bh2pDm/empty-a-directory-in-service-file-as-execstartpre
                    ExecStart = "${pkgs.findutils}/bin/find ${config.home.homeDirectory}/Pictures/Screenshots -mindepth 1 -delete";
                };
                Install = {
                    WantedBy = [ "default.target" ];
                };
            };
        };
    };
}