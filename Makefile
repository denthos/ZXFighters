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

# Included ASM Files
#
# Uncomment the below line to automatically pull in asm files in the src directory as included asm files.
# Be aware that this means that any malformed asm files in the src directory will cause all compilation
# to fail even if they are not depended on by the main asm file.
# INCASM = $(patsubst -i $(ASMFILE),,$(patsubst %,-i %,$(wildcard $(SRCDIR)/*.asm)))
#
# For this version, you must add `-i <filename>` for every new asm file introduced.
# Example: INCASM = -i file1.asm -i file2.asm
INCASM =

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
$(BINFILE): $(ASMFILE) $(Z80ASM) $(ASMDIR) $(BINDIR)
	$(Z80ASM) -o $@ $(#INCASM) $(ASMFILE)

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
