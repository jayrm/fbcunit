##########################

MAKEFILES := src/makefile

##########################

MAKE := make.exe

.SUFFIXES:

VPATH = $(LIBDIR)

##########################

all: fbcunit tests

fbcunit: src/makefile
	$(MAKE) -C $(<D) -f $(<F)

.PHONY: tests
tests:
	$(MAKE) -C tests -f makefile

.PHONY: clean
clean:
	$(MAKE) -C src -f makefile clean
	$(MAKE) -C tests -f makefile clean
