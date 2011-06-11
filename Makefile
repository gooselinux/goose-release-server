# This makefile is downloading an archive found in 
# the 'archive' file already existing in this directory
# and validating the md5sum of the archive against it.

CURL	?= $(shell if test -f /usr/bin/curl ; then echo "curl -H Pragma: -O -R -S --fail --show-error" ; fi)
WGET	?= $(shell if test -f /usr/bin/wget ; then echo "wget -nd -m" ; fi)
CLIENT	?= $(if $(CURL),$(CURL),$(if $(WGET),$(WGET)))

LOOKASIDE_HOST := http://herlo.org/misc
SOURCEFILES := $(shell cat archive 2>/dev/null | awk '{ print $$2 }')

sources: $(SOURCEFILES)

$(SOURCEFILES):
	$(CLIENT) $(LOOKASIDE_HOST)/$(SOURCEFILES)
	md5sum -c archive || ( echo 'MD5 check failed' && rm $(SOURCEFILES); exit 1 )

clean:
	rm goose-release-6.tar.gz
