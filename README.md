# dxvk-gentoo-overlay
Experimental ebuild repository for [DXVK](https://github.com/doitsujin/dxvk) winelib builds

## Examples
```sh
# Example: Build DXVK from git master
emerge -1 games-util/dxvk:9999 -q

# Example: Install DXVK (+utils use flag)
WINEPREFIX=/path/to/prefix dxvk-setup-9999

# Example: Run DXVK test (+test use flag)
# This one require "native" (read windows) d3dcompiler_47.dll
# WINEDLLOVERRIDES="d3dcompiler_47,d3d11,dxgi=n"
WINEPREFIX=/path/to/prefix wine /usr/lib/dxvk-0.70/bin/d3d11-triangle.exe.so
```

### DXVK requirements to pay attention
* `>=sys-devel/gcc-7.3.0`<br>
  C++ code require full c++17 standart implementation, `7.3.0` is current minimal suitable version in portage tree
* `>=app-emulation/wine-*-3.14`<br>
  first version with winegcc/winevulkan support for 32 bit binaries
* latest drivers<br>
  see https://github.com/doitsujin/dxvk/wiki/Driver-support <br>
  and https://developer.nvidia.com/vulkan-driver

### Content
`# USE="test utils abi_x86_32" emerge -1 games-util/dxvk:0.70 -q`<br>

`$ equery f games-util/dxvk:0.70 | less` (cuted)

```
/usr/lib/dxvk-0.70/bin/d3d11-compute.exe.so
/usr/lib/dxvk-0.70/bin/d3d11-formats.exe.so
/usr/lib/dxvk-0.70/bin/d3d11-streamout.exe.so
/usr/lib/dxvk-0.70/bin/d3d11-triangle.exe.so
/usr/lib/dxvk-0.70/bin/dxbc-compiler.exe.so
/usr/lib/dxvk-0.70/bin/dxbc-disasm.exe.so
/usr/lib/dxvk-0.70/bin/dxgi-factory.exe.so

/usr/lib/dxvk-0.70/d3d10.dll.so
/usr/lib/dxvk-0.70/d3d10_1.dll.so
/usr/lib/dxvk-0.70/d3d10core.dll.so
/usr/lib/dxvk-0.70/d3d11.dll.so
/usr/lib/dxvk-0.70/dxgi.dll.so

/usr/lib64/dxvk-0.70/bin/d3d11-compute.exe.so
/usr/lib64/dxvk-0.70/bin/d3d11-formats.exe.so
/usr/lib64/dxvk-0.70/bin/d3d11-streamout.exe.so
/usr/lib64/dxvk-0.70/bin/d3d11-triangle.exe.so
/usr/lib64/dxvk-0.70/bin/dxbc-compiler.exe.so
/usr/lib64/dxvk-0.70/bin/dxbc-disasm.exe.so
/usr/lib64/dxvk-0.70/bin/dxgi-factory.exe.so

/usr/lib64/dxvk-0.70/d3d10.dll.so
/usr/lib64/dxvk-0.70/d3d10_1.dll.so
/usr/lib64/dxvk-0.70/d3d10core.dll.so
/usr/lib64/dxvk-0.70/d3d11.dll.so
/usr/lib64/dxvk-0.70/dxgi.dll.so

/usr/share/doc/dxvk-0.70/README.md.bz2

/usr/share/dxvk-0.70/setup_dxvk_winelib.verb
```

### Tests
```sh
#!/bin/sh

mkdir -p /tmp/dxvk-test

export WINEPREFIX="$(pwd)/dxvk-test"
#export WINEDLLOVERRIDES="d3dcompiler_47,d3d11,dxgi=n"
#export DXVK_HUD=version,devinfo,fps

wine /usr/lib64/dxvk-0.70/bin/dxgi-factory.exe.so
```
NOTE: will also produse `dxgi-factory_dxgi.log` in current directory. Usually there are several of them depending which library used.

### Read more
https://github.com/doitsujin/dxvk#hud - environment variables<br>
https://github.com/doitsujin/dxvk/wiki/Configuration - configuration file example
