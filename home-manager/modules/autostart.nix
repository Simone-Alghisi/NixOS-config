{ config, pkgs, ...}:

{
    home.file.".config/autostart/thunderbird.desktop" = {
        source = config.lib.file.mkOutOfStoreSymlink "${pkgs.thunderbird}/share/applications/thunderbird.desktop";
        executable = true;
    };

    home.file.".config/autostart/telegramdesktop.desktop" = {
        source = config.lib.file.mkOutOfStoreSymlink "${pkgs.unstable.tdesktop}/share/applications/telegramdesktop.desktop";
        executable = true;
    };
}