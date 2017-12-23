##########################

ifndef TARGET
$(error TARGET variable not set.  must be set to one of win32, win64)
endif

ifeq ($(TARGET), win32)
	EXEEXT := .exe
else
	ifeq ($(TARGET), win64)
		EXEEXT := .exe
	else
		$(error TARGET variable must be set to one of win32, win64)
	endif
endif

##########################

MAIN := tests

EXE := $(MAIN)$(EXEEXT)

SRCS := $(MAIN).bas
SRCS += fbcu_test.bas

##########################

FBC := fbc$(EXEEXT)
FBCFLAGS := -w pedantic

FBCFLAGS += -i ../inc
FBCFLAGS += -p ../lib/$(TARGET)

ifeq ($(DEBUG),1)
FBCFLAGS += -exx -g
endif

LIBS := $(wildcard ../lib/$(TARGET)/*.a)

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

.PHONY: clean
clean:
	-rm -f $(OBJS) $(EXE)
