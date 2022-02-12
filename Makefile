CC=gcc
CFLAGS?=-Wall -O2
LDFLAGS?=-lm #-s # - strip for win
AR?=ar
INSTALL?=install
RM?=rm -f # not working for win
RMD?=$(RM) -r # not working for win
PREFIX?=/usr/local
SRCS=src
DOCS=/usr/share/doc/aec_cmdline
BINS=bin
MANS=man/man1

all: aec_cmdline

aec_cmdline: $(SRCS)/aec_cmdline.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean: # not working for win
	$(RM) aec_cmdline $(SRCS)/*.o

install:
	$(INSTALL) -d $(PREFIX)/$(BINS)
	$(INSTALL) -d $(PREFIX)/$(MANS)
	$(INSTALL) -m 0755 aec_cmdline $(PREFIX)/$(BINS)
	$(INSTALL) -m 0644 README.md $(DOCS)
	$(INSTALL) -m 0644 LICENSE $(DOCS)
	$(INSTALL) -m 0644 $(MANS)/helmeltrans.1 $(PREFIX)/$(MANS)

uninstall:
	$(RM) $(PREFIX)/$(BINS)/aec_cmdline
	$(RMD) $(DOCS)
	$(RM) $(PREFIX)/$(MANS)/aec_cmdline.1
