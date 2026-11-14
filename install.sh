#!/bin/bash
# install.sh — install manual-duplex system-wide (run with sudo)
set -eu

PREFIX="${PREFIX:-/usr/local}"

install -m 755 manual-duplex "$PREFIX/bin/manual-duplex"
install -m 644 manual-duplex.desktop /usr/share/applications/manual-duplex.desktop
update-desktop-database /usr/share/applications 2>/dev/null || true

echo "Installed: $PREFIX/bin/manual-duplex"
echo "Installed: /usr/share/applications/manual-duplex.desktop"
echo
echo "Try it:  manual-duplex document.pdf"
