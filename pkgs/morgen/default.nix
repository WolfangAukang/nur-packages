{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, makeWrapper, electron,
alsa-lib, gtk3, libxshmfence, mesa, nss }:

stdenv.mkDerivation rec {
  pname = "morgen";
  version = "210203";

  src = fetchurl {
    url = "https://dl.todesktop.com/${version}cqcj00tw1/linux/deb/x64";
    sha256 = "sha256-ELSz66Bo492PVBrAxzykWN1q4vx0AAtuO8hi/0Hignk=";
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
    substituteInPlace $out/share/applications/morgen.desktop --replace '/opt/Morgen' $out/bin
    cat $out/share/applications/morgen.desktop

    makeWrapper ${electron}/bin/electron \
      $out/bin/morgen \
      --add-flags $out/opt/Morgen/resources/app.asar
  '';

  meta = with lib; {
    description = "All-in-one Calendars, Tasks and Scheduler";
    homepage = "https://morgen.so/download";
    license = licenses.unfree;
    maintainers = with maintainers; [ wolfangaukang ];
    platforms = [ "x86_64-linux" ];
  };
}
