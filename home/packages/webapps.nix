{ pkgs, lib, ... }:
{
    home.packages = [ pkgs.brave ];

    xdg.desktopEntries.tasks = {
        name = "Tasks Google";
        exec = "${lib.getExe pkgs.brave} --app=https://tasks.google.com/tasks/";
    };
    xdg.desktopEntries.whatsapp = {
        name = "Whatsapp";
        exec = "${lib.getExe pkgs.brave} --app=https://web.whatsapp.com/";
    };
}
