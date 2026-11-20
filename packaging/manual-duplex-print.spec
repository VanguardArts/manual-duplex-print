Name:           manual-duplex-print
Version:        1.3.2
Release:        1%{?dist}
Summary:        Manual duplex printing wizard for single-sided CUPS printers

License:        GPL-3.0-or-later
URL:            https://github.com/VanguardArts/manual-duplex-print
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       bash, cups-client
Suggests:       kdialog
Suggests:       zenity
Suggests:       libreoffice-core
Suggests:       pandoc

%description
A "fake duplexer wizard": prints odd pages, waits for the printer,
prompts you to flip and reload the stack, then prints even pages on the
backs. Brings Windows-style manual duplex to Linux for printers without
duplex hardware (e.g. Epson EcoTank L3250/ET-2810).

Non-PDF office documents are converted automatically via LibreOffice
or pandoc when installed. Integrates with file managers via a desktop
entry (right-click a document -> Open With -> Manual Duplex Print).

%prep
%setup -q

%build
# nothing to compile

%install
install -Dm755 manual-duplex %{buildroot}%{_bindir}/manual-duplex
install -Dm644 manual-duplex.desktop %{buildroot}%{_datadir}/applications/manual-duplex.desktop

%files
%{_bindir}/manual-duplex
%{_datadir}/applications/manual-duplex.desktop
%doc README.md
%license LICENSE

%changelog
* Sat Nov 21 2026 Vanguard Arts SRL <https://vanguardarts.vip/> - 1.3.2-1
* Sat Nov 14 2026 Vanguard Arts SRL - 1.2.0-1
- Screenshots in docs, RPM and AUR packaging

* Sat Nov 14 2026 Vanguard Arts SRL - 1.1.0-1
- Office format auto-conversion (LibreOffice, pandoc fallback)

* Sat Nov 14 2026 Vanguard Arts SRL - 1.0.0-1
- Initial release
