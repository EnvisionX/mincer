.PHONY: all clean

PWD = $(shell pwd)
MINCER_CONF = $(PWD)/mincer.conf
MINCER_PATH = $(shell readlink --canonicalize-missing "$(PWD)/../..")
export PATH := $(PATH):$(MINCER_PATH)
MINCER = $(MINCER_PATH)/mincer

ROOTDIR = $(PWD)/rootdir
INCOMING = $(ROOTDIR)/incoming
OUTPUT0 = $(ROOTDIR)/output
OUTPUT1 = $(ROOTDIR)/output1
OUTPUT2 = $(ROOTDIR)/output2
OUTPUT3 = $(ROOTDIR)/output3
FAILED = $(ROOTDIR)/failed

all: clean $(MINCER_CONF)
	mkdir -p "$(ROOTDIR)"
# Start the daemon
	"$(MINCER)" "$(MINCER_CONF)"
	sleep 0.5s
# Inject good file
	echo "good" > "$(INCOMING)/a"
	sleep 0.5s
	test ! -f "$(INCOMING)/a"
	test -f "$(OUTPUT0)/a.res"
	test `cat "$(OUTPUT0)/a.res"` = "ok"
	test ! -f "$(OUTPUT1)/a.res"
	test -f "$(OUTPUT2)/a.res"
	test `cat "$(OUTPUT2)/a.res"` = "ok"
	test -f "$(OUTPUT3)/a.res"
	test `cat "$(OUTPUT3)/a.res"` = "ok"
# Inject bad file
	echo "bad" > "$(INCOMING)/b"
	sleep 0.5s
	test ! -f "$(OUTPUT0)/b.res"
	test ! -f "$(OUTPUT1)/b.res"
	test ! -f "$(OUTPUT2)/b.res"
	test ! -f "$(OUTPUT3)/b.res"
	test -f "$(FAILED)/b"
	test `cat "$(FAILED)/b"` = "bad"
# Make one of output dirs non-writable and inject good file.
# No files must be created in any of the output directories.
	chmod 0555 "$(OUTPUT3)"
	echo "good" > "$(INCOMING)/c"
	sleep 0.5s
	test ! -f "$(INCOMING)/c"
	test -f "$(FAILED)/c"
	test `cat "$(FAILED)/c"` = "good"
	test ! -f "$(OUTPUT0)/c.res"
	test ! -f "$(OUTPUT0)/c.res.tmp"
	test ! -f "$(OUTPUT1)/c.res"
	test ! -f "$(OUTPUT1)/c.res.tmp"
	test ! -f "$(OUTPUT2)/c.res"
	test ! -f "$(OUTPUT2)/c.res.tmp"
	test ! -f "$(OUTPUT3)/c.res"
	test ! -f "$(OUTPUT3)/c.res.tmp"
# Stop the daemon
	"$(MINCER)" "$(MINCER_CONF)" stop

$(MINCER_CONF):
	sed 's#@@ROOTDIR@@#$(ROOTDIR)#' $@.in > $@

clean:
	"$(MINCER)" "$(MINCER_CONF)" stop || :
	test -d "$(OUTPUT3)" && chmod 0755 "$(OUTPUT3)" || :
	rm -rf -- "$(ROOTDIR)" "$(MINCER_CONF)"
