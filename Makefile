.POSIX:

PREFIX?=/usr/local
MANPREFIX?=${PREFIX}/share/man
BINPREFIX?=${PREFIX}/bin

test: shpec/bin/shpec
	@PATH=$$PWD/bin:$$PATH \
	SHTUC_TEST_DIR=$$PWD \
	shpec/bin/shpec t

shpec/bin/shpec: submodules
	@cd shpec && make bin/shpec

submodules:
	@git submodule update --init --recursive

install: install-bin install-man

install-bin:
	chmod -R +x bin
	mkdir -p ${BINPREFIX}
	cp -r -v bin/* ${BINPREFIX}/

install-man:
	mkdir -p ${MANPREFIX}
	cp -r -v man/* ${MANPREFIX}/
