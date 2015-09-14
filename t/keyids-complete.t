#!/bin/sh
# Makes sure every key in arctica-*-gpg has an entry in the
# keyids mapping file.
set -e

fail=0

for keyring in arctica-maintainers-gpg arctica-keyring-gpg; do
	cd $keyring
	for key in 0x*; do
		if ! grep -q "^$key " ../keyids; then
			echo "$keyring: $key is not in keyids file."
			fail=1
		fi
	done
	cd ..
done

exit $fail
