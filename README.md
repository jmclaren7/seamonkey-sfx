# SeaMonkey Browser Portable
This build script and supplementary files will debloat, compress and turn the SeaMonkey Browser into a portable app. This is done using 7-zip SFX which is included along with an already debloated copy of SeaMonkey. 

My purpose for this is to have a single file portable browser that can also run in a 64bit only environment. this serves as a universal solution to run a browser on WinPE and Windows Server Core (without wow64) but also as a way to easily start a browser from a remote access tool like ScreenSconnect with it's unique "back stage" feature.

<p align="center">
  <img src="https://raw.githubusercontent.com/jmclaren7/seamonkey-sfx/master/Extra/Screenshot1.png?raw=true">
</p>


## Resource Hacker
The only thing not included is the freeware tool [Resource Hacker](https://www.angusj.com/resourcehacker/), if this is installed on your system or along side the script then the build script can add the SeaMonkey icon to the generated EXE along with removing the required administrator privileges that are default with with the 7-Zip SFX module.

## Debloating
This was done by trial and error, some features are broken (like dev tools) but for my purposes it's worth saving the space, the smallest EXE I've made so far is 33MB. If you start with a fresh copy of a SeaMonkey program folder, the Build script can debloat it in the same way I did, or you can adjust it to fit your needs. If you find more or better ways to reduce the size, let me know.