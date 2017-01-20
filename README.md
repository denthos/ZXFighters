## CSE 190 ##
The repo comes prepackaged with [z80asm](http://www.nongnu.org/z80asm/) and [zxtap](https://github.com/AlbertVeli/ZX_Beep/tree/master/ZX_Tap). The Makefile will automatically compile their binaries within their folders when/if necessary.


----------


**Dependencies**

 - make
 - gcc

----------
**Build Instructions**

Simply type `make` in the top level folder to compile the assembly in the `src` folder into its respective binaries and tapes which are placed in the `binaries` and `tapes` folders. `make clean` and `make distclean` are also available. Be aware that there are two version of the INCASM variable in the Makefile. The first (commented out by default) automatically pulls in all .asm files in the src directory for addition to the binaries and tapes when compiling. The second (enabled by default) requires that you manually add new .asm files to the Makefile in order for them to be compiled.


----------


**Notes for Windows**

 Using [MinGW](http://mingw.org/) with mingw32-make.exe and gcc.exe (mingw32-gcc.exe also works) installed, I was able to successfully pull, build, and then run the tape with the [Fuse emulator for Windows](https://sourceforge.net/projects/fuse-emulator/files/fuse/1.3.2/fuse-1.3.2-win32-setup.exe/download).
