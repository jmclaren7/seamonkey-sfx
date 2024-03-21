# SeaMonkey Browser Portable
This build script and supplementary files will debloat, compress and turn the SeaMonkey Browser into a portable app. This is done using 7-zip SFX which is included along with an already debloated copy of the programs. The size of the portable file is around 33MB.

My purpose for this is to have a single file portable program that can also run in a 64bit only environment. This serves as a universal solution to run it on WinPE and Windows Server Core (without wow64) but also as a way to run it easily from a remote access tool like ScreenSconnect with it's unique "back stage" feature.

<p align="center">
  <img src="https://raw.githubusercontent.com/jmclaren7/seamonkey-sfx/master/Extra/Screenshot1.png?raw=true">
</p>

## Resource Hacker
The only thing not included is the freeware tool [Resource Hacker](https://www.angusj.com/resourcehacker/), if this is installed on your system or along side the script then the build script can add the program icon to the generated EXE along with adjusting the required administrator privileges that are default with with the 7-Zip SFX module.

## Debloating
This was done by trial and error, some features could be broken but everything I need is working. If you start with a fresh copy of the program folder, the build script can debloat it in the same way I did, or you can adjust it to fit your needs. If you find more or better ways to reduce the size, let me know.