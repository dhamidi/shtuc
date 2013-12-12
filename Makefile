.POSIX:

PREFIX?=/usr/local
MANPREFIX?=${PREFIX}/share/man
BINPREFIX?=${PREFIX}/bin

test:
	@PATH=$$PWD/bin:$$PATH \
	SHTUC_TEST_DIR=$$PWD \
	bin/shpec t

install: install-bin install-man

install-bin:
	chmod -R +x bin
	mkdir -p ${BINPREFIX}
	cp -r -v bin/* ${BINPREFIX}/

install-man:
	mkdir -p ${MANPREFIX}
	cp -r -v man/* ${MANPREFIX}/
