# Nix package for manual-duplex-print (a bash "fake duplexer" wizard).
#
# Build with:  nix build
# Cups client tools (lp/lpstat) are put on PATH; kdialog/zenity and
# LibreOffice/pandoc are optional at runtime (the script falls back to the
# terminal and offers to install converters on demand).
{ lib, stdenv, makeWrapper, cups }:

stdenv.mkDerivation rec {
  pname = "manual-duplex-print";
  version = "1.3.1";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall
    install -Dm755 manual-duplex "$out/bin/manual-duplex"
    sed "s|^Exec=.*|Exec=$out/bin/manual-duplex %f|" manual-duplex.desktop \
      > "$out/share/applications/manual-duplex.desktop"
    wrapProgram "$out/bin/manual-duplex" --prefix PATH : "${cups}/bin"
    runHook postInstall
  '';

  meta = with lib; {
    description = "Manual duplex printing wizard for single-sided CUPS printers";
    homepage = "https://github.com/VanguardArts/manual-duplex-print";
    license = licenses.gpl3Plus;
    mainProgram = "manual-duplex";
    platforms = platforms.linux;
  };
}
