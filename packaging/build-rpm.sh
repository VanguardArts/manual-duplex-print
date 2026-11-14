#!/bin/bash
# build-rpm.sh — build the manual-duplex-print .rpm package
# Run from the repository root:  ./packaging/build-rpm.sh
set -eu

cd "$(dirname "$0")/.."
VERSION=$(grep -m1 '^VERSION=' manual-duplex | cut -d'"' -f2)
TOP=$(mktemp -d)
trap 'rm -rf "$TOP"' EXIT

mkdir -p "$TOP"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# source tarball matching the spec's %setup expectations
TARDIR="manual-duplex-print-$VERSION"
mkdir -p "$TOP/SOURCES/$TARDIR"
cp manual-duplex manual-duplex.desktop README.md LICENSE "$TOP/SOURCES/$TARDIR/"
tar -czf "$TOP/SOURCES/$TARDIR.tar.gz" -C "$TOP/SOURCES" "$TARDIR"
rm -rf "$TOP/SOURCES/$TARDIR"

sed "s/^Version:.*/Version:        $VERSION/" packaging/manual-duplex-print.spec > "$TOP/SPECS/pkg.spec"

rpmbuild --define "_topdir $TOP" -bb "$TOP/SPECS/pkg.spec"
find "$TOP/RPMS" -name '*.rpm' -exec cp {} . \;
echo "Built: $(ls manual-duplex-print-*.rpm)"
