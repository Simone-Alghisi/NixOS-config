{ config, pkgs, ...}:

{
    home.file.".local/bin/ovhai" = {
        source = (pkgs.fetchzip {
            url = "https://cli.gra.training.ai.cloud.ovh.net/ovhai-linux.zip";
            sha256 = "sha256-aW/Riy5rtdqhrURh90cX4S3v2QLrHVpzhMX4pin/oB4=";
          });
    };
}
