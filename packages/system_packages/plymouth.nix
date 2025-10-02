{ lib, systemSettings, pkgs, ... }:
lib.mkIf (systemSettings.enablePlymouth) {
	boot = {
		plymouth = {
			enable = true;
			theme = systemSettings.plymouthTheme;
			themePackages = with pkgs; [
				(adi1090x-plymouth-themes.override {
					selected_themes = [ "${systemSettings.plymouthTheme}" ];
				})
			];
		};

		loader.timeout = 0;
		loader.systemd-boot.editor = false;
		kernelParams = [
			"quiet"
			"splash"
			"vga=current"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];

		# Enable "Silent boot"
		consoleLogLevel = 0;
		initrd.verbose = false;
	};
}
