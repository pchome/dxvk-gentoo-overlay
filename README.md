# dxvk-gentoo-overlay
Experimental ebuild repository for DXVK winelib builds

# DXVK requirements to pay attention
* `>=sys-devel/gcc-7.3.0`<br>
  C++ code require full c++17 standart implementation, `7.3.0` is current minimal suitable version in portage tree
* `>=app-emulation/wine-*-3.14`<br>
  first version with winegcc/winevulkan support for 32 bit binaries
* latest drivers<br>
  see https://github.com/doitsujin/dxvk/wiki/Driver-support <br>
  and https://developer.nvidia.com/vulkan-driver

# How to build

## Example: Build DXVK from git master
`# emerge -1 games-util/dxvk:9999 -q`

# How to install

## Example: Install DXVK
`$ WINEPREFIX=/path/to/prefix dxvk-setup-9999`
