{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, makeWrapper, electron
, alsa-lib, glibc, gtk3, libxshmfence, mesa, nss }:

stdenv.mkDerivation rec {
  pname = "threema-desktop";
  version = "1.0.3";

  src = fetchurl {
    # As Threema only offers a Latest Release url, the plan is to upload each
    # new release to archive.org until their Github releases gets populated.
    url = "https://archive.org/download/threema-${version}/Threema-${version}.deb";
    sha256 = "sha256-qiFv52nnyfHxCWTePmyxW/MgzFy3EUxmW6n+UIkw7tk=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];

  buildInputs = [ alsa-lib glibc gtk3 libxshmfence mesa nss ];

  dontBuild = true;
  dontConfigure = true;

  unpackPhase = ''
    # Can't unpack with the common dpkg-deb -x
    dpkg --fsys-tarfile $src | tar --extract
  '';

  installPhase = ''
    runHook preInstall

    mv usr $out

    runHook postInstall
  '';

  postFixup = ''
    substituteInPlace $out/share/applications/threema.desktop \
      --replace 'Exec=threema' Exec=$out/bin/threema
    makeWrapper ${electron}/bin/electron \
      $out/bin/threema \
      --add-flags $out/lib/threema/resources/app.asar
  '';

  meta = with lib; {
    description = "Desktop client for Threema, a privacy-focused end-to-end encrypted mobile messenger";
    homepage = "https://threema.ch";
    license = licenses.agpl3Only;
    maintainers = with maintainers; [ wolfangaukang ];
    platforms = [ "x86_64-linux" ];
  };
}
