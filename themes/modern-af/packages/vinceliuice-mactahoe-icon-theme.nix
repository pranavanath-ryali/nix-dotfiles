{ pkgs, stdenv, lib, fetchFromGithub }:
stdenv.mkDerivation {
    pname = "vinceliuice-mactahoe-icon-theme";
    version = "2025-10-16";

    src = fetchFromGithub {
        owner = "vinceliuice";
        repo = "MacTahoe-icon-theme";
        rev = "master";
        sha256 = lib.fakeSha256;
    };

    buildInputs = with pkgs; [
        # coreutils 
        gtk4
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
