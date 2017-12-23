##########################

ifndef TARGET
$(error TARGET variable not set.  must be set to one of win32, win64)
endif

MAKE := make

.SUFFIXES:

VPATH = .

##########################

.PHONY: all
all: fbcunit tests

.PHONY: fbcunit
fbcunit: src/makefile
	$(MAKE) -C $(<D) -f $(<F) all

.PHONY: tests
tests: tests/makefile
	$(MAKE) -C $(<D) -f $(<F) all

.PHONY: clean
clean:
	$(MAKE) -C tests -f makefile clean
	$(MAKE) -C src -f makefile clean
