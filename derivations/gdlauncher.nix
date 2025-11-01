{ appimageTools, fetchurl }:

appimageTools.wrapType2 {
	pname = "gdlauncher";
	version = "2.0.24";
	src = fetchurl {
		url = "https://gdlauncher.com/download/linux";
		hash = "sha256-d5ZvWSLA/7mY0540TDLMW9qmEFA5xC6Zd83IWakOmGo=";
	};
}
