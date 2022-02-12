CC=gcc
CFLAGS?=-Wall -O3
LDFLAGS?=-lspeexdsp
AR?=ar
INSTALL?=install
RM?=rm -f
RMD?=$(RM) -r
PREFIX?=/usr/local
SRCS=src
DOCS=/usr/share/doc/aec_cmdline
BINS=bin
MANS=man/man1
CONFS=conf
ALSACONF=/etc/alsa/conf.d

all: aec_cmdline

aec_cmdline: $(SRCS)/aec_cmdline.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

clean: # not working for win
	$(RM) aec_cmdline $(SRCS)/*.o

install:
	$(INSTALL) -d $(PREFIX)/$(BINS)
	$(INSTALL) -d $(PREFIX)/$(MANS)
	$(INSTALL) -d $(DOCS)
	$(INSTALL) -d $(ALSACONF)
	$(INSTALL) -m 0755 aec_cmdline $(PREFIX)/$(BINS)
	$(INSTALL) -m 0644 README.md $(DOCS)
	$(INSTALL) -m 0644 LICENSE $(DOCS)
	$(INSTALL) -m 0644 $(MANS)/aec_cmdline.1 $(PREFIX)/$(MANS)
	$(INSTALL) -m 0644 $(CONFS)/50-aec.conf $(ALSACONF)
	
uninstall:
	$(RM) $(PREFIX)/$(BINS)/aec_cmdline
	$(RMD) $(DOCS)
	$(RM) $(PREFIX)/$(MANS)/aec_cmdline.1
	$(RM) $(ALSACONF)/50-aec.conf
