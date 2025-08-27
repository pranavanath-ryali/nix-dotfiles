{
	description = "arstarst";

	inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		anyrun.url = "github:anyrun-org/anyrun";
		anyrun.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = inputs@{ self, nixpkgs, anyrun, ...  }:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in {
	};
}
