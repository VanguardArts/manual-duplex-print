#!/bin/bash
# build-deb.sh — build the manual-duplex-print .deb package
# Run from the repository root:  ./packaging/build-deb.sh
set -eu

cd "$(dirname "$0")/.."
VERSION=$(grep -m1 '^VERSION=' manual-duplex | cut -d'"' -f2)
PKG="manual-duplex-print_${VERSION}_all"
BUILD=$(mktemp -d)
trap 'rm -rf "$BUILD"' EXIT

mkdir -p "$BUILD/$PKG/DEBIAN" "$BUILD/$PKG/usr/bin" \
         "$BUILD/$PKG/usr/share/applications" \
         "$BUILD/$PKG/usr/share/doc/manual-duplex-print"

install -m 755 manual-duplex "$BUILD/$PKG/usr/bin/manual-duplex"
install -m 644 manual-duplex.desktop "$BUILD/$PKG/usr/share/applications/"
install -m 644 README.md "$BUILD/$PKG/usr/share/doc/manual-duplex-print/"

sed "s/^Version:.*/Version: $VERSION/" packaging/deb-control > "$BUILD/$PKG/DEBIAN/control"

cat > "$BUILD/$PKG/DEBIAN/postinst" <<'EOF'
#!/bin/sh
update-desktop-database /usr/share/applications 2>/dev/null || true
exit 0
EOF
chmod 755 "$BUILD/$PKG/DEBIAN/postinst"

dpkg-deb --build --root-owner-group "$BUILD/$PKG"
mv "$BUILD/$PKG.deb" .
echo "Built: $PKG.deb"
