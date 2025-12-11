{ pkgs, lib, ... }:
{
    home.packages = [ pkgs.brave ];

    xdg.desktopEntries.whatsapp = {
        name = "Whatsapp";
        icon = "whatsapp";
        categories = [ "Network" "WebBrowser" ];
        exec = "${lib.getExe pkgs.brave} --app=https://web.whatsapp.com/";
    };
}
