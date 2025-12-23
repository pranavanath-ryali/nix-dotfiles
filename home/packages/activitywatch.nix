{ pkgs, ... }:
{
    services.activitywatch = {
        enable = true;
        watchers = {
            aw-watcher-window = {
                package = pkgs.aw-watcher-window-wayland;
                settings = {
                    poll_time = 1;
                    exclude_title = true;
                };
            };
        };
    };
}
