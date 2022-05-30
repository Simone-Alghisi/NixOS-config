{ config, pkgs, ...}:

{
    home = {
        sessionVariables = {
            MOZ_ENABLE_WAYLAND = "1";
        };
    };
}