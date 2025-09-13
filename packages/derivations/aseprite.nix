{
	description = "Build Aseprite from source with Skia";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs }: let
		
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };

	in {
		packages.${system}.default = let
			
			skia = pkgs.stdenv.mkDerivation {
				pname = "aseprite-skia";
				version = "m102";

				src = pkgs.fetchFromGitHub {
					owner = "aseprite";
					repo = "skia";
					rev = "m102-861e47447f";
					sha256 = "sha256-yF9HDqDrJcfVgTObgGJE0IVl2IvFeqGVHUi8sU3Aa3E=";
				};

				nativeBuildInputs = [ pkgs.cmake pkgs.ninja pkgs.python3 pkgs.pkg-config ];
				buildInputs = [ pkgs.freetype pkgs.fontconfig pkgs.libpng pkgs.zlib ];

				configurePhase = ''
					mkdir -p build
					cd build
					cmake .. \
						-G Ninja \
						-DCMAKE_BUILD_TYPE=Release \
						-DSKIA_BUILD_SHARED_LIBS=OFF \
						-DSKIA_ENABLE_SVG=ON \
						-DSKIA_ENABLE_AVIF=OFF \
						-DSKIA_ENABLE_SKOTTIE=OFF
				'';

				buildPhase = "ninja";
				installPhase = ''
					mkdir -p $out
					cp -r ../include $out/
					cp -r lib $out/
				'';
			};

		in 
	}
}
