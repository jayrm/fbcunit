FBC := fbc

LIBRARY := lib/libfbcunit.a
SRCS    := src/fbcunit.bas
HDRS    := inc/fbcunit.bi

TEST_SRCS := tests/tests.bas
TEST_SRCS += tests/fbcu_test.bas
TEST_OBJS := $(patsubst %.bas,%.o,$(TEST_SRCS))
TEST_EXE  := tests/tests.exe

FBCFLAGS += -g -exx -i ./inc

.SUFFIXES: .bas

VPATH = .

.PHONY: all
all: $(LIBRARY)

.PHONY: tests
tests: $(TEST_EXE)

$(LIBRARY): $(SRCS) $(HDRS)
	$(FBC) $(FBCFLAGS) -lib $(SRCS) -x $(LIBRARY)

tests/%.o: tests/%.bas $(HDRS)
	$(FBC) $(FBCFLAGS) -m tests -c $< -o $@

$(TEST_EXE): $(TEST_OBJS) $(LIBRARY)
	$(FBC) $(FBCFLAGS) $(TEST_OBJS) -p ./lib -x $(TEST_EXE)

.PHONY: clean
clean:
	-rm -f $(LIBRARY)
	-rm -f $(TEST_OBJS) $(TEST_EXE)
