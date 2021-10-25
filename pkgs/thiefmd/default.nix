{ lib, stdenv, fetchgit, fetchurl, copyDesktopItems, makeDesktopItem, wrapGAppsHook,
cmake, desktop-file-utils, glib, meson, ninja, pkg-config, vala, clutter, discount,
gtk3, gtksourceview4, gtkspell3, libarchive, libgee, libhandy, libsecret, link-grammar,
webkitgtk }:

let
  app_icon = fetchurl {
    url = "https://thiefmd.com/images/thiefmd_48.png";
    sha256 = "sha256-0tlP+5mfLSUJ+KV7FnDpYvLyvwKfuKQf6kraHwvlR6k=";
  };

in stdenv.mkDerivation rec {
  pname = "thiefmd";
  version = "0.2.4-easypdf";

  src = fetchgit {
    url = "https://github.com/kmwallio/ThiefMD.git";
    rev = "v${version}";
    sha256 = "sha256-YN17o6GtpulxhXs+XYZLY36g9S8ggR6URNLrjs5PEoI=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake copyDesktopItems desktop-file-utils glib meson wrapGAppsHook
    ninja pkg-config vala
  ];

  buildInputs = [
    clutter discount gtk3 gtksourceview4 gtkspell3
    libarchive libgee libhandy libsecret link-grammar
    webkitgtk
  ];

  dontUseCmakeConfigure = true;

  desktopItems = makeDesktopItem {
    name = pname;
    exec = "thiefmd";
    icon = app_icon;
    comment = meta.description;
    desktopName = "ThiefMD";
    genericName = "Markdown Editor";
  };

  postInstall = ''
    makeWrapper $out/bin/com.github.kmwallio.thiefmd \
      $out/bin/thiefmd \
      --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}/"
  '';

  meta = with lib; {
    description = "Markdown & Fountain editor that helps with organization and management";
    homepage = "https://thiefmd.com";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ wolfangaukang ];
  };
}
