# compiler toolchain
CC ?= gcc
CXX ?= g++
WX_CONFIG ?= wx-config
CXXFLAGS ?= -O2 -pipe -Wall
CPPFLAGS ?= -I./src $(shell $(WX_CONFIG) --cxxflags all)
LIBS += $(shell $(WX_CONFIG) --libs all)

# tools
INSTALL = install
INSTALL_PROGRAM = $(INSTALL) -Dm755
INSTALL_SCRIPT = $(INSTALL) -Dm755
INSTALL_DATA = $(INSTALL) -Dm644
TAR = tar
RM = rm -f

# variables
PN = treesheets
PV = 9999
TARGET = $(PN)

# install destinations
PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
DATADIR ?= $(PREFIX)/share/$(PN)
DOCDIR ?= $(PREFIX)/share/doc/$(PN)-$(PV)
HTMLDIR ?= $(DOCDIR)/html

# sources
SRCDIR = src
OBJDIR = obj
TARGETDIR = bin
SOURCES  := $(wildcard $(SRCDIR)/*.cpp)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)


### rules ###
$(TARGETDIR)/$(TARGET): $(OBJECTS)
	@echo -e "\033[1;31mLinking $@ \033[0m"
	$(CXX) $(LIBS) $(OBJECTS) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.cpp
	@echo -e "\033[1;32mCompiling $<\033[0m"
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $< -o $@

# TODO: remove for loops and install each file manually
# which will enable us to create proper uninstall rules
install: $(TARGETDIR)/$(TARGET)
	$(INSTALL_PROGRAM) "$(TARGETDIR)/$(TARGET)" "$(DESTDIR)$(BINDIR)/$(TARGET)"
	for f in $(shell cd TS/images && find . -type f) ; do \
		$(INSTALL_DATA) TS/images/$$f "$(DESTDIR)$(DATADIR)/images/$$f" ; done
	for f in $(shell cd TS/examples && find . -type f) ; do \
		$(INSTALL_DATA) TS/examples/$$f "$(DESTDIR)$(DATADIR)/examples/$$f" ; done
	for f in $(shell cd TS/docs && find . -maxdepth 1 -type f) ; do \
		$(INSTALL_DATA) TS/docs/$$f "$(DESTDIR)$(DOCDIR)/$$f" ; done
	for f in $(shell cd TS/docs/html && find . -type f) ; do \
		$(INSTALL_DATA) TS/docs/html/$$f "$(DESTDIR)$(HTMLDIR)/$$f" ; done

clean:
	$(RM) $(wildcard $(OBJDIR)/*.o)
	$(RM) $(TARGETDIR)/$(TARGET)

.PHONY: install clean
