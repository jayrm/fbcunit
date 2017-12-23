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

LIBDIR := $(BASEDIR)/lib/$(TARGET)
INCDIR := $(BASEDIR)/inc

LIBRARY := $(LIBDIR)/lib$(LIBNAME).a
LIBS := $(patsubst %,$(LIBDIR)/lib%.a,$(DEP_LIBS))
OBJDIR := $(BASEDIR)/obj/$(TARGET)

OBJS := $(patsubst %.bas,$(OBJDIR)/%.o,$(SRCS))

##########################

FBC := fbc.exe
FBCFLAGS := -w pedantic

ifeq ($(DEBUG),1)
FBCFLAGS += -exx -g
endif

FBCFLAGS += -i $(INCDIR)
FBCFLAGS += -p $(LIBDIR)

.SUFFIXES:
.SUFFIXES: .bas

VPATH = .

$(OBJDIR)/%.o : %.bas $(HDRS) $(LIBS)
	$(FBC) $(FBCFLAGS) -c $< -o $@

##########################

all: $(LIBNAME)

$(LIBNAME): $(LIBRARY)

$(LIBRARY): $(OBJS) $(LIBS)
	$(FBC) -lib $(FBCFLAGS) $(OBJS) $(LIBS) -x $(LIBRARY)

.PHONY : clean_library
clean_library:
	-rm -f $(OBJS) $(LIBRARY)
