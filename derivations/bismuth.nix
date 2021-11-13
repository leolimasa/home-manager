{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "bismuth";

  src = pkgs.fetchFromGitHub {
    owner = "Bismuth-Forge";
    repo = "bismuth";
    rev = "v2.1.0";
    sha256 = "1gn6w7l23ml42l6mwn6xmbgw0rj2arra60mkc5ibp2ymbf04cai0";
  };

  buildInputs = with pkgs; [
    stdenv
    gettext
    cmake
    extra-cmake-modules
    ninja
    libsForQt5.kconfig
    libsForQt5.kconfigwidgets
    libsForQt5.ki18n
    libsForQt5.kcoreaddons
    libsForQt5.kdeclarative
    libsForQt5.kcmutils
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtdeclarative
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.knotifications
    libsForQt5.kpackage
    libsForQt5.kservice
    libsForQt5.kiconthemes
    libsForQt5.kdoctools
    libsForQt5.kauth
    libsForQt5.kcrash
    libsForQt5.kjobwidgets
    libsForQt5.kio
  ];

  buildPhase = ''
    npm install
  '';

  installPhase = ''
    npm run bi-install
  '';
}


