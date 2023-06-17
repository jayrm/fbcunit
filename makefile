FBC := fbc

ECHO := echo

LIBDIR := lib

ifneq ($(ARCH),)
	FBCFLAGS += -arch $(ARCH)
endif
ifneq ($(TARGET),)
	FBCFLAGS += -target $(TARGET)
	LIBDIR := lib/$(TARGET)
endif
ifneq ($(FPU),)
	FBCFLAGS += -fpu $(FPU)
endif

LIBNAME := libfbcunit.a
SRCS    := src/fbcunit.bas
SRCS    += src/fbcunit_qb.bas
SRCS    += src/fbcunit_console.bas
SRCS    += src/fbcunit_report.bas

HDRS    := inc/fbcunit.bi
HDRS    += src/fbcunit_types.bi
HDRS    += src/fbcunit_console.bi
HDRS    += src/fbcunit_report.bi

TEST_SRCS := tests/tests.bas
TEST_SRCS += tests/fbcu_sanity.bas
TEST_SRCS += tests/fbcu_multiple.bas
TEST_SRCS += tests/fbcu_global.bas
TEST_SRCS += tests/fbcu_many_tests.bas
TEST_SRCS += tests/fbcu_append.bas
TEST_SRCS += tests/fbcu_append2.bas
TEST_SRCS += tests/fbcu_float.bas
TEST_SRCS += tests/fbcu_namespace.bas
TEST_SRCS += tests/fbcu_default.bas
TEST_SRCS += tests/fbcu_order.bas
TEST_SRCS += tests/fbcu_cases.bas
TEST_SRCS += tests/fbcu_console.bas

TEST_OBJS := $(patsubst %.bas,%.o,$(TEST_SRCS))

TEST_EXE  := tests/tests.exe

EXAMPLES := examples/ex01.exe
EXAMPLES += examples/ex02.exe
EXAMPLES += examples/ex03.exe
EXAMPLES += examples/ex04.exe
EXAMPLES += examples/ex05.exe
EXAMPLES += examples/ex06.exe
EXAMPLES += examples/ex07.exe
EXAMPLES += examples/ex08.exe
EXAMPLES += examples/ex09.exe
EXAMPLES += examples/ex10.exe
EXAMPLES += examples/ex11.exe

FBCFLAGS += -mt -g -exx -i ./inc

.SUFFIXES: .bas

VPATH = .

.PHONY: all
all: library

$(LIBDIR):
	mkdir -p $@

.PHONY: help
help:
	@$(ECHO) "usage: make target [options]"
	@$(ECHO) ""
	@$(ECHO) "Targets:"
	@$(ECHO) "   help           - displays this information"
	@$(ECHO) "   library        - builds $(LIBRARY)"
	@$(ECHO) "   tests          - builds tests for fbcunit"
	@$(ECHO) "   examples       - builds all the examples"
	@$(ECHO) "   everything     - builds library, tests, examples"
	@$(ECHO) "   clean          - cleans up all built files"
	@$(ECHO) ""
	@$(ECHO) "Options:"
	@$(ECHO) "   FBC=/path/fbc  - set path to FBC compiler"
	@$(ECHO) "   TARGET=target"
	@$(ECHO) "   ARCH=arch (default is 486)"
	@$(ECHO) "   FPU=fpu | sse"
	@$(ECHO) "Defaults:"
	@$(ECHO) "   FBC=fbc"
	@$(ECHO) "   LIBDIR=/path/<target>"

.PHONY: everything
everything: library tests examples

.PHONY: library
library: $(LIBDIR)/$(LIBNAME)

.PHONY: tests
tests: $(TEST_EXE) 

.PHONY: examples
examples: $(EXAMPLES)

$(LIBDIR)/$(LIBNAME): $(SRCS) $(HDRS) | $(LIBDIR)
	$(FBC) $(FBCFLAGS) -lib $(SRCS) -x $@

tests/%.o: tests/%.bas $(HDRS)
	$(FBC) $(FBCFLAGS) -m tests -c $< -o $@

examples/%.exe: examples/%.bas $(HDRS) $(LIBDIR)/$(LIBNAME)
	$(FBC) $(FBCFLAGS) $< -p $(LIBDIR) -x $@

$(TEST_EXE): $(TEST_OBJS) $(LIBDIR)/$(LIBNAME)
	$(FBC) $(FBCFLAGS) $(TEST_OBJS) -p $(LIBDIR) -x $@

.PHONY: clean
clean:
	-rm -f $(LIBDIR)/$(LIBNAME)
	-rm -f $(TEST_OBJS) $(TEST_EXE)
	-rm -f $(EXAMPLES)
