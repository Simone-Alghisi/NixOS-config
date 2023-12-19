{ config, pkgs, ...}:

{
    home.file.".config/autostart/thunderbird.desktop" = {
        source = config.lib.file.mkOutOfStoreSymlink "${pkgs.thunderbird}/share/applications/thunderbird.desktop";
    };

    home.file.".config/autostart/org.telegram.desktop.desktop" = {
        source = config.lib.file.mkOutOfStoreSymlink "${pkgs.tdesktop}/share/applications/org.telegram.desktop.desktop";
    };
}
