{ ... }:
{
	programs.firefox = {
		enable = true;
		profiles = {
			my-profile = {
				extensions.force = true;
			};
		};
	};
}
