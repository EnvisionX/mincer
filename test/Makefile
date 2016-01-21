TESTS = main multi_output

.PHONY: all clean $(TESTS)

all: $(TESTS)

clean: $(TESTS)

$(TESTS):
	$(MAKE) -C $@ $(MAKECMDGOALS)
