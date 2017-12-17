##########################


FBC := fbc.exe
FBCFLAGS := -w pedantic

FBCFLAGS += -i ../inc
FBCFLAGS += -p ../lib/win32

ifeq ($(DEBUG),1)
FBCFLAGS += -exx -g
endif

LIBS := $(wildcard ../lib/win32/*.a)

MAIN := tests

EXE := $(MAIN).exe

SRCS := $(MAIN).bas
SRCS += fbcu_test.bas

OBJS := $(patsubst %.bas,%.o,$(SRCS))

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

%.o : %.bas $(HDRS)
	$(FBC) $(FBCFLAGS) -m $(MAIN) -c $< -o $@

##########################

all: $(EXE)

$(EXE): $(OBJS) $(HDRS) $(FBCLIBS) $(LIBS)
	$(FBC) $(FBCFLAGS) $(OBJS) -x $@

.PHONY : clean
clean:
	-rm -f $(OBJS)
