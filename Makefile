.POSIX:

test:
	PATH=$$PWD/bin:$$PATH bin/shpec t
