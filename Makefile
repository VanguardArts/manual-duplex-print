PREFIX ?= /usr/local

.PHONY: install uninstall
install:
	PREFIX=$(PREFIX) ./install.sh

uninstall:
	PREFIX=$(PREFIX) ./uninstall.sh
