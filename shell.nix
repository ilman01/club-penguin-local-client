{ pkgs ? import <nixpkgs> {} }:

let
  libs = with pkgs; [
    mesa
    glib
    alsa-lib
    nss
    nspr
    dbus

    atk
    at-spi2-atk
    at-spi2-core

    gtk3
    pango
    cairo
    gdk-pixbuf

    libxcb
    libxkbcommon
    libdrm
    libgbm

    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXtst

    expat
    cups
  ];
in
pkgs.mkShell {
  packages = libs ++ [
    pkgs.nodejs
    pkgs.yarn
  ];

  #NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;
  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath libs;

  shellHook = ''
    export XDG_DATA_DIRS=${pkgs.gtk3}/share:${pkgs.gsettings-desktop-schemas}/share:$XDG_DATA_DIRS
    export XDG_CURRENT_DESKTOP=GNOME
  '';
}