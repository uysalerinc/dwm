{
  description = "My custom DWM window manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "dwm";
      src = self;

      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        xorg.libX11
        xorg.libXft
        xorg.libXinerama
        freetype
      ];

      prePatch = ''
        sed -i 's@/usr/local@$out@g' config.mk
      '';

      installPhase = ''
        make PREFIX=$out install
      '';
    };
  };
}
