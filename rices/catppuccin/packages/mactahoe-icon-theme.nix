{ pkgs, stdenv, fetchFromGithub }:
stdenv.mkDerivation {
    pname = "vinceliuice-mactahoe-icon-theme";
    version = "2025-10-16";

    src = fetchFromGithub {
        owner = "vinceliuice";
        repo = "MacTahoe-icon-theme";
        rev = "master";
        sha256 = "sha256-tgZMflZqdaTmFvf3zArpwlD+i3SPHt0PsMjgMc20+PM=";
    };

    buildInputs = with pkgs; [
        # coreutils 
        gtk3
        jdupes
        hicolor-icon-theme
    ];

    dontPatchELF = true;
    dontRewriteSymlinks = true;
    dontDropIconThemeCache = true;
    
    postPatch = ''
        patchShebangs install.sh
    '';

    installPhase = ''
        runHook preInstall

        ./install.sh --dest $out/share/icons \
            --name MacTahoe \
            --theme default \

        jdupes --link-soft --recurse $out/share

        runHook postInstall
    '';
}
