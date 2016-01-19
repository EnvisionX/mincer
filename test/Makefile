.PHONY: all clean

PWD = $(shell pwd)
MINCER_CONF = $(PWD)/mincer.conf
MINCER_PATH = $(shell readlink --canonicalize-missing "$(PWD)/..")
export PATH := $(PATH):$(MINCER_PATH)
MINCER = $(MINCER_PATH)/mincer

ROOTDIR = $(PWD)/rootdir
INCOMING = $(ROOTDIR)/incoming
OUTPUT = $(ROOTDIR)/output
HISTORY = $(ROOTDIR)/history
FAILED = $(ROOTDIR)/failed

all: clean $(MINCER_CONF)
	mkdir -p $(ROOTDIR)
# Start the daemon
	$(MINCER) $(MINCER_CONF)
	sleep 0.5s
# Inject good file
	echo "good" > "$(INCOMING)/a.data"
	sleep 0.5s
	test -f "$(HISTORY)/a.data.gz"
	test `zcat "$(HISTORY)/a.data.gz"` = "good"
	test -f "$(OUTPUT)/a.data.result"
# Inject bad file
	echo "bad" > "$(INCOMING)/b.data"
	sleep 0.5s
	test ! -f "$(HISTORY)/b.data.gz"
	test ! -f "$(OUTPUT)/b.data.result"
	test -f "$(FAILED)/b.data"
# Inject good file again
	echo "good" > "$(INCOMING)/c.data"
	sleep 0.5s
	test -f "$(HISTORY)/c.data.gz"
	test `zcat "$(HISTORY)/c.data.gz"` = "good"
	test -f "$(OUTPUT)/c.data.result"
# Inject file with bad filename
	echo "good" > "$(INCOMING)/badfilename.datum"
	sleep 1s
	test -f "$(INCOMING)/badfilename.datum"
	test ! -f "$(HISTORY)/badfilename.datum"
	test ! -f "$(OUTPUT)/badfilename.datum.result"
# Long inject (file must be processed only after file close)
	{ echo good; sleep 3s; echo notgood; } > "$(INCOMING)/d.data"
	sleep 0.5s
	test ! -f "$(HISTORY)/d.data.gz"
	test ! -f "$(OUTPUT)/d.data.result"
	test -f "$(FAILED)/d.data"
# Stop the daemon
	$(MINCER) $(MINCER_CONF) stop

$(MINCER_CONF):
	sed 's#@@ROOTDIR@@#$(ROOTDIR)#' $@.in > $@

clean:
	$(MINCER) $(MINCER_CONF) stop || :
	rm -rf -- $(ROOTDIR) $(MINCER_CONF)
