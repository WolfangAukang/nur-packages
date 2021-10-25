{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, makeWrapper, electron,
alsa-lib, gtk3, libxshmfence, mesa, nss }:

stdenv.mkDerivation rec {
  pname = "whalebird";
  version = "4.4.5";

  src = fetchurl {
    url = "https://github.com/h3poteto/whalebird-desktop/releases/download/${version}/Whalebird-${version}-linux-x64.deb";
    sha256 = "sha256-CIlj9Sc/hj2UMgQzfHA3iQYO6EPqcndqkNUCBecHq+E=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [ alsa-lib gtk3 libxshmfence mesa nss ];

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = ''
    dpkg-deb -x ${src} ./
  '';

  installPhase = ''
    runHook preInstall

    mv usr $out
    mv opt $out

    runHook postInstall
  '';

  postFixup = ''
    substituteInPlace $out/share/applications/whalebird.desktop --replace '/opt/Whalebird' $out/bin
    makeWrapper ${electron}/bin/electron \
      $out/bin/whalebird \
      --add-flags $out/opt/Whalebird/resources/app.asar
  '';

  meta = with lib; {
    description = "Electron based Mastodon, Pleroma and Misskey client for Windows, Mac and Linux";
    homepage = "whalebird.social";
    license = licenses.mit;
    maintainers = with maintainers; [ wolfangaukang ];
    platforms = [ "x86_64-linux" ];
  };
}
