##########################

LIBDIR := $(BASEDIR)/lib/win32
INCDIR := $(BASEDIR)/inc

LIBRARY := $(LIBDIR)/lib$(LIBNAME).a
LIBS := $(patsubst %,$(LIBDIR)/lib%.a,$(DEP_LIBS))
OBJDIR := $(BASEDIR)/obj

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
