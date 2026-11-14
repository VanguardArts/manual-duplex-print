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
![release](https://img.shields.io/github/v/release/VanguardArts/manual-duplex-print)

## Supported file formats

| Format | Converter used | Works without LibreOffice? |
|---|---|---|
| **PDF** | none needed | ✅ |
| **doc / docx / odt / rtf** | LibreOffice → *pandoc fallback* | ✅ with pandoc (except `.doc`) |
| **ppt / pptx / odp** | LibreOffice | ❌ — LibreOffice required |
| **xls / xlsx / ods** | LibreOffice | ❌ — LibreOffice required |
| **md / html / epub / txt** | pandoc | ✅ |
| Anything else | — | Export to PDF from your application first |

Conversion happens automatically and invisibly — you can right-click a
`.docx` exactly the same way as a `.pdf`. The tool tries LibreOffice
first (best fidelity), falls back to **pandoc** (lightweight, ~30 MB)
for text documents, and if neither is installed it explains what to do.
The converted PDF is temporary and deleted after printing.

> **No LibreOffice? No problem** for PDFs (nothing extra needed) or
> text documents (`sudo apt install pandoc`). Only presentations and
> spreadsheets truly need LibreOffice.

## Installation

### Option 1 — Debian/Ubuntu package (easiest)

Download `manual-duplex-print_1.1.0_all.deb` from the
[latest release](https://github.com/VanguardArts/manual-duplex-print/releases/latest)
and either double-click it, or install from a terminal:

```sh
sudo apt install ./manual-duplex-print_1.1.0_all.deb
```

Remove it later with `sudo apt remove manual-duplex-print`.

### Option 2 — Install script (any distro)

```sh
git clone https://github.com/VanguardArts/manual-duplex-print.git
cd manual-duplex-print
sudo ./install.sh          # or: sudo make install
```

Uninstall with `sudo ./uninstall.sh` (or `sudo make uninstall`).

### What gets installed

- `/usr/local/bin/manual-duplex` — the tool itself
- `/usr/share/applications/manual-duplex.desktop` — app-menu entry and
  *Open With* integration for documents

### Dependencies

- `bash`, CUPS client tools (`cups-client` on Debian/Ubuntu) — required
- `kdialog` **or** `zenity` — recommended for GUI prompts (falls back to
  terminal prompts without them)
- `libreoffice` — optional, only needed for non-PDF office documents
- `pandoc` — optional lightweight alternative converter for text
  documents (docx/odt/rtf/md/html/epub/txt)
- The odd/even page filtering uses the standard `cups-filters` pipeline
  present on virtually all distros — no setup needed

## How to use it

### From your file manager (the easy way)

1. **Right-click** a PDF or office document
2. Choose **Open With → Manual Duplex Print**
   - KDE/Dolphin: right-click → *Open With* → *Other Application…* →
     **Manual Duplex Print** (optionally tick *Remember* to make it stick)
   - GNOME/Files (Nautilus): right-click → *Open With Other Application* →
     **Manual Duplex Print**
3. Follow the on-screen wizard: odd pages print, a dialog tells you how to
   flip and reload the stack, click **Yes**, even pages print on the backs.

You can also launch **Manual Duplex Print** from your app menu with no
arguments — it opens a file picker.

### From the terminal

```sh
manual-duplex document.pdf            # uses the system default printer
manual-duplex report.docx             # office formats work too (needs LibreOffice)
manual-duplex -p L3250_Series doc.pdf # pick a specific CUPS queue
manual-duplex --short-edge doc.pdf    # short-edge flip instructions
```

Set a persistent printer via the environment:

```sh
export DUPLEX_PRINTER=L3250_Series
```

### Tips

- **Test the flip orientation first** with a short (4-page) document.
  Paper path differs between printers (rear feed vs. cassette), so check
  that page 2 lands correctly behind page 1 before printing something long.
- Keep the stack **in order** when reloading — the even pages are printed
  assuming you flipped the stack as-is.
- If page 2 comes out upside-down or misordered, try `--short-edge` or
  flip the stack the other way — then open an issue so we can add your
  printer's quirk to the docs.

## How it works

Nothing exotic: it submits two CUPS jobs with `-o page-set=odd` /
`-o page-set=even` (handled by `cups-filters`' `pdftopdf`), polls
`lpstat -o` to detect when the first pass finishes, converts non-PDF input
with headless LibreOffice, and uses desktop dialogs for the wizard steps.
A single dependency-light bash script — no daemon, no background service.

## Contributing

Issues and pull requests welcome — especially printer-specific flip
instructions, translations of the dialog text, and packaging for more
distros (.rpm, Flatpak, AUR).

## License

GPL-3.0-or-later. See [LICENSE](LICENSE).
