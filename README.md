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


 ----------


 **Game Specs**


Title Menu

 - 1P Mode
 - 2P Mode (if we have time)
 - Instructions

1P Mode

 - Select Character
 - Series of fights
  - Fight X enemies in a row
  - Restore all health between each fight
  - Enemies randomly selected
  - Enemies grow progressively harder (can simply use HP + damage modifier for enemies)
  - Gain score each round (flat score for winning + hp left + time taken to win)
 - End screen (with music that changes for victory/defeat) that shows high scores
 - Back to title menu
  - Possibly let player press escape at any time to go back to title menu

2P Mode

 - Select Character
 - Single fight between both (maybe bo3)
  - Bottom of screen will have to be separated in a nice way (possibly abbreviate abilities?)
 - Victory screen showing winner with victory music
 - Back to title menu
  - Possibly let player press escape at any time to go back to title menu

Instructions Page

 - Display hardcoded page of controls + description of modes
 - Any key returns to title menu

Character Selection

 - X characters
 - Arrow keys to move over characters
  - Currently selected character has colors set to flash
  - Currently selected characters abilities are shown in bottom of screen
 - For 2P Mode, can split bottom of screen to have both players choose at once, or just have each player pick one after the other

Battle Screen

- HP + CD for each character along top
- Characters shown in middle
 - Characters should (hopefully) have idle and ability animations
- Bottom of screen has 4 states
 - Ability is being used: text displays what ability was used and the resulting damage
 - No ability is being used: text displays both of your abilities and dodge option
 - Dodging: text displays "Preparing to dodge..." or something to that effect
 - Ability was dodged: text displays which ability was dodged

Character Data

 - Name
 - Two abilities
  - Each ability has a corresponding damage and cooldown
  - Each ability has a corresponding animation (hopefully)
 - HP
 - Animations
  - Idle
  - Attacking
  - Being hit
  - Dodge

Additional Notes

 - Might need to have abilities that have interesting effects so all abilities don't feel the same (if we can handle the complexity)
  - Damage over time
  - Increase their CD
  - Strike through dodge
  - Heal yourself
