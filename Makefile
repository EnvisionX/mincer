.PHONY: all test clean

all:

test:
	$(MAKE) -C test

clean:
	$(MAKE) -C test $@
