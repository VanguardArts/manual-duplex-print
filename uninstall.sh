#!/bin/bash
# uninstall.sh — remove manual-duplex (run with sudo)
set -eu

PREFIX="${PREFIX:-/usr/local}"

rm -f "$PREFIX/bin/manual-duplex"
rm -f /usr/share/applications/manual-duplex.desktop
update-desktop-database /usr/share/applications 2>/dev/null || true

echo "manual-duplex removed."
