# Gold Team Makefile

# Name
NAME = main

# Folder Declarations
SRCDIR = src
BINDIR = binaries
TAPEDIR = tapes
ZXTAPDIR = zxtap
Z80ASMDIR = z80asm

# File Declarations
ASMFILE = $(SRCDIR)/$(NAME).asm
BINFILE = $(BINDIR)/$(NAME).bin
TAPEFILE = $(TAPEDIR)/$(NAME).tap
ALLSRC = $(SRCDIR)/*.asm $(SRCDIR)/characters/*.asm

# ZXTAP Options
REMS =
BORDERCOLOR = 0
PAPER = 7
INK = 0
ZXTOPTS = $(REMS) -b $(BORDERCOLOR) -p $(PAPER) -i $(INK)
ZXTAP = $(ZXTAPDIR)/zxtap

# Z80ASM Options
Z80ASM = $(Z80ASMDIR)/z80asm

# C Compilation Flags
CFLAGS = -O2 -W -Wall

all: $(TAPEFILE)

# Compile Tape File
$(TAPEFILE): $(BINFILE) $(ZXTAP) $(BINDIR) $(TAPEDIR)
	$(ZXTAP) -o $@ $(ZXTOPTS) $(BINFILE)

# Compile Bin File
$(BINFILE): $(ASMFILE) $(Z80ASM) $(ASMDIR) $(BINDIR) $(ALLSRC)
	$(Z80ASM) -o $@ $(ASMFILE)

# Create Tape Directory
$(TAPEDIR):
	mkdir -p $(TAPEDIR)

# Create Bin Directory
$(BINDIR):
	mkdir -p $(BINDIR)

# Create ASM Directory
$(ASMDIR):
	mkdir -p $(ASMDIR)

# Compile ZXTAP
$(ZXTAP):
	make -C $(ZXTAPDIR)

# Compile Z80ASM
$(Z80ASM):
	make -C $(Z80ASMDIR)

.PHONY: clean distclean

clean:
	rm -f $(TAPEFILE) $(BINFILE)

distclean: clean
	make -C $(ZXTAPDIR) clean
	make -C $(Z80ASMDIR) clean
