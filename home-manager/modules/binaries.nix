{ config, pkgs, ...}:

{
    home.file.".local/bin/ovhai" = {
        source = (pkgs.fetchzip {
            url = "https://cli.gra.training.ai.cloud.ovh.net/ovhai-linux.zip";
            sha256 = "sha256-MsRsS5Ni8bFFWIFlq5k5z/oWsvgrRgtQbGBA18fgXr8=";
          });
    };
}
