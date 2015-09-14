PREFIX ?= /usr/local
DESTDIR ?=

all: output/keyrings/arctica-maintainers.gpg output/keyrings/arctica-keyring.gpg output/sha512sums.txt output/README

output/keyrings/arctica-maintainers.gpg: arctica-maintainers-gpg/0x*
	mkdir -p output/keyrings/
	cat arctica-maintainers-gpg/0x* > output/keyrings/arctica-maintainers.gpg

output/keyrings/arctica-keyring.gpg: arctica-keyring-gpg/0x*
	mkdir -p output/keyrings/
	cat arctica-keyring-gpg/0x* > output/keyrings/arctica-keyring.gpg

output/sha512sums.txt: output/keyrings/arctica-maintainers.gpg
	cd output; sha512sum keyrings/* > sha512sums.txt

output/README: README
	cp README output/

install:
	install -o root -g root -m 0755 -d $(DESTDIR)/usr/share/keyrings
	install -o root -g root -m 0644 output/keyrings/*.gpg $(DESTDIR)/usr/share/keyrings/

test: output/keyrings/arctica-maintainers.gpg output/keyrings/arctica-keyring.gpg
	./runtests

clean:
	rm -f output/keyrings/*.gpg output/sha512sums.txt output/README output/keyrings/*~
