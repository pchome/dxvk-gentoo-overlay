# dxvk-gentoo-overlay
Experimental ebuild repository for [DXVK](https://github.com/doitsujin/dxvk) winelib builds
```ini
# Add to e.g. /etc/portage/repos.conf/external.conf
[dxvk]
location = /var/db/repos/dxvk
sync-type = git
sync-depth = 1
sync-uri = https://github.com/pchome/dxvk-gentoo-overlay
auto-sync = true
priority = 60
# Run `# emerge --sync dxvk` or `# eix-sync` (app-portage/eix)
```

## Examples
```sh
# Example: Build DXVK from git master
emerge -1 games-util/dxvk:9999 -q

# Example: Install DXVK (+utils use flag)
$ WINEPREFIX=/path/to/prefix dxvk-setup-9999

# Example: Run DXVK test (+test use flag)
# This one require "native" (read windows) d3dcompiler_47.dll
# WINEDLLOVERRIDES="d3dcompiler_47,d3d11,dxgi=n"
$ WINEPREFIX=/path/to/prefix wine /usr/lib/dxvk-0.70/bin/d3d11-triangle.exe.so

# Example: check/merge changes for 9999 versions
emerge app-portage/smart-live-rebuild -q
smart-live-rebuild -p

# Example: Test unmerged PRs/patches
# On https://github.com/doitsujin/dxvk/pulls pick one and add ".patch" to url
mkdir -p /etc/portage/patches/games-util/dxvk-9999
wget https://github.com/doitsujin/dxvk/pull/581.patch -O /etc/portage/patches/games-util/dxvk-9999/0001-patch-name.patch
emerge -1 games-util/dxvk:9999 -q
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
