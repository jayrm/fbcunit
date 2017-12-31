FBC := fbc

LIBRARY := lib/libfbcunit.a
SRCS    := src/fbcunit.bas
SRCS    += src/fbcunit_qb.bas
HDRS    := inc/fbcunit.bi

TEST_SRCS := tests/tests.bas
TEST_SRCS += tests/fbcu_sanity.bas
TEST_SRCS += tests/fbcu_multiple.bas
TEST_SRCS += tests/fbcu_global.bas

TEST_OBJS := $(patsubst %.bas,%.o,$(TEST_SRCS))

TEST_EXE  := tests/tests.exe

EXAMPLES := examples/ex01.exe
EXAMPLES += examples/ex02.exe
EXAMPLES += examples/ex03.exe
EXAMPLES += examples/ex04.exe
EXAMPLES += examples/ex05.exe
EXAMPLES += examples/ex06.exe

FBCFLAGS += -g -exx -i ./inc

.SUFFIXES: .bas

VPATH = .

.PHONY: all
all: $(LIBRARY) tests examples

.PHONY: tests
tests: $(TEST_EXE) 

.PHONY: examples
examples: $(EXAMPLES)

$(LIBRARY): $(SRCS) $(HDRS)
	$(FBC) $(FBCFLAGS) -lib $(SRCS) -x $@

tests/%.o: tests/%.bas $(HDRS)
	$(FBC) $(FBCFLAGS) -m tests -c $< -o $@

examples/%.exe: examples/%.bas $(LIBRARY)
	$(FBC) $(FBCFLAGS) $< -p ./lib -x $@

$(TEST_EXE): $(TEST_OBJS) $(LIBRARY)
	$(FBC) $(FBCFLAGS) $(TEST_OBJS) -p ./lib -x $@

.PHONY: clean
clean:
	-rm -f $(LIBRARY)
	-rm -f $(TEST_OBJS) $(TEST_EXE)
	-rm -f $(EXAMPLES)
