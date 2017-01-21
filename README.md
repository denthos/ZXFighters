## CSE 190 ##
The repo comes prepackaged with [z80asm](http://www.nongnu.org/z80asm/) and [zxtap](https://github.com/AlbertVeli/ZX_Beep/tree/master/ZX_Tap). The Makefile will automatically compile their binaries within their folders when/if necessary.


----------


**Dependencies**

 - make
 - gcc

----------
**Build Instructions**

Simply type `make` in the top level folder to compile the assembly in the `src` folder into its respective binaries and tapes which are placed in the `binaries` and `tapes` folders. `make clean` and `make distclean` are also available. Be aware that in order to use new .asm files you must include them via "include" statements that the assembler uses.


----------


**Notes for Windows**

 Using [MinGW](http://mingw.org/) with mingw32-make.exe and gcc.exe (mingw32-gcc.exe also works) installed, I was able to successfully pull, build, and then run the tape with the [Fuse emulator for Windows](https://sourceforge.net/projects/fuse-emulator/files/fuse/1.3.2/fuse-1.3.2-win32-setup.exe/download).
 
 Bash on Ubuntu on Windows is another option for pulling, building and running the Fuse emulator. 
 Instructions: (http://www.windowscentral.com/how-install-bash-shell-command-line-windows-10).