# Contributing

Issues and pull requests are welcome!

## Especially valuable contributions

- **Printer-specific flip instructions** — paper paths vary (rear feed vs.
  cassette); tell us what worked for your printer and we'll document it
- **Dialog translations** — the wizard text is plain English strings in
  `manual-duplex`; help us make it multilingual
- **Distro packaging** — see below

## Packaging

All packaging lives in `packaging/`:

| File | Purpose |
|---|---|
| `build-deb.sh` + `deb-control` | Build the Debian/Ubuntu `.deb` |
| `build-rpm.sh` + `manual-duplex-print.spec` | Build the Fedora/RHEL `.rpm` |
| `PKGBUILD` | Arch Linux package |

Run `./packaging/build-deb.sh` or `./packaging/build-rpm.sh` from the repo
root; the version is picked up automatically from the `VERSION=` line in
`manual-duplex`.

### Publishing to the AUR

Publishing `PKGBUILD` to the Arch User Repository requires your own AUR
account (SSH key at https://aur.archlinux.org). If you'd like to be the
AUR maintainer for this package, open an issue — we'd love the help.
Remember to run `updpkgsums` to replace the `SKIP` checksum.

## Code style

`manual-duplex` is a single bash script on purpose — no daemon, no
build system. Please keep it dependency-light, POSIX-minded, and
`bash -n`-clean. Test GUI changes under both kdialog and zenity if you can.
