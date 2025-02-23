{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "dwm";
  version = "custom";

  src = pkgs.fetchFromGitHub {
    owner = "your-username";
    repo = "dwm";
    rev = "your-branch-or-commit"; # e.g., "main" or "a1b2c3d"
    sha256 = "0000000000000000000000000000000000000000000000000000"; # Replace with the actual hash
  };

  buildInputs = with pkgs; [
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    freetype
  ];

  prePatch = ''
    sed -i 's@/usr/local@${placeholder "out"}@g' config.mk
  '';

  installPhase = ''
    make PREFIX=$out install
  '';
}
