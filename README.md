# dxvk-gentoo-overlay
Experimental ebuild repository for [DXVK](https://github.com/doitsujin/dxvk) winelib builds

**NOTE**: This overlay rather stalled. See http://gpo.zugaina.org/app-emulation/dxvk for alternatives.

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
emerge -1 games-util/dxvk:1.1.1 -q

# Example: Install DXVK
$ WINEPREFIX=/path/to/prefix dxvk-setup-1.1.1 install --without-dxgi --symlink
```

### DXVK requirements to pay attention
* `>=sys-devel/gcc-7.3.0`<br>
  C++ code require full C++17 standard implementation (c++1z/c++17), `7.3.0` is current minimal suitable version in portage tree.
  
* `>=app-emulation/wine-*-3.14`<br>
  first version with winegcc/winevulkan support for 32 bit binaries
  
* latest drivers<br>
  see https://github.com/doitsujin/dxvk/wiki/Driver-support <br>
  and https://developer.nvidia.com/vulkan-driver


### Known issues
* Even when `.dll.so` libs renamed to `.dll` WINE recognizes them as both "builtin" and "native", so DLL Overrides don't work as expected.<br>
  You may need to remove them completely from your WINE prefix to use "builtin" versions.<br>
  "builtin" here mean WINE's and "native" -- Windows DLL.
  
* *winelib build* method is rather new for DXVK, especially 32 bit builds.<br>
  If you encountered some problems -- check one of official releases (built w/ MinGW) from https://github.com/doitsujin/dxvk/releases for comparison.

### Read more
https://github.com/doitsujin/dxvk#hud - environment variables<br>
https://github.com/doitsujin/dxvk/wiki/Configuration - configuration file example
