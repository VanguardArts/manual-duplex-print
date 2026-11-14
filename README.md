# Manual Duplex Print

A **"fake duplexer wizard"** for Linux — print double-sided documents on
printers that have **no duplex hardware** (e.g. Epson EcoTank L3250 /
ET-2810 and many other budget inkjets).

On Windows, vendor drivers include a *manual duplex* assistant. CUPS has no
such feature, so print dialogs (Okular, Evince, etc.) show the two-sided
option greyed out. `manual-duplex` fills the gap:

1. Prints all **odd** pages
2. Watches the CUPS queue until the printer is physically finished
3. Shows a dialog with **flip instructions** and waits for you to reload the paper
4. Prints all **even** pages on the backs

![license](https://img.shields.io/badge/license-GPL--3.0-blue)

## Features

- Works with any single-sided CUPS printer
- KDE (**kdialog**) and GNOME (**zenity**) dialogs, with automatic fallback
  to plain terminal prompts
- Integrates with your file manager: right-click a PDF → *Open With* →
  **Manual Duplex Print**
- Long-edge (default) and short-edge flip instructions
- No daemon, no background service — a single dependency-light bash script

## Dependencies

- `bash`
- CUPS client tools: `lp`, `lpstat` (`cups-client` package on Debian/Ubuntu)
- `kdialog` **or** `zenity` (recommended; optional)
- CUPS must be able to print odd/even page sets of PDFs — provided by the
  standard `cups-filters` (`pdftopdf`) setup present on virtually all distros

## Installation

```sh
git clone https://github.com/VanguardArts/manual-duplex-print.git
cd manual-duplex-print
sudo ./install.sh          # or: sudo make install
```

This installs `/usr/local/bin/manual-duplex` and a desktop entry so the tool
appears in your app menu and in *Open With* dialogs for PDF files.

Uninstall with `sudo ./uninstall.sh` (or `sudo make uninstall`).

## Usage

```sh
manual-duplex document.pdf            # uses the system default printer
manual-duplex -p L3250_Series doc.pdf # pick a specific CUPS queue
manual-duplex --short-edge doc.pdf    # short-edge flip instructions
manual-duplex                         # opens a file picker
```

You can also set a persistent printer via the environment:

```sh
export DUPLEX_PRINTER=L3250_Series
```

### Tips

- **Test the flip orientation first** with a short (4-page) document.
  Paper path differs between printers (rear feed vs. cassette), so check
  that page 2 lands correctly behind page 1 before printing something long.
- Keep the stack **in order** when reloading — the tool prints the even
  pages assuming you flipped the stack as-is.
- If your printer mangles page 2, try the other binding mode
  (`--short-edge`) or flip the stack the other way; then adjust your
  routine — or open an issue/PR to add your printer's quirk.

## How it works

Nothing exotic: it submits two CUPS jobs with `-o page-set=odd` /
`-o page-set=even` (handled by `cups-filters`' `pdftopdf`), polls
`lpstat -o` to detect when the first pass finishes, and uses desktop
dialogs for the wizard steps.

## Contributing

Issues and pull requests welcome — especially printer-specific flip
instructions, translations of the dialog text, and packaging for distros
(.deb/.rpm, Flatpak, AUR).

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).
