{ config, pkgs, ...}:

{
    home.file.".config/zotero/plugins/better_bibtex.xpi" = {
        source = (builtins.fetchurl {
            url = "https://github.com/retorquere/zotero-better-bibtex/releases/download/v6.7.17/zotero-better-bibtex-6.7.17.xpi";
            sha256 = "194iyfx4bqh57kvyajzxglmicn29jm5wq0blwzrgmgqf14s0rqnd";
          });
    };
    home.packages = [pkgs.zotero];
}
