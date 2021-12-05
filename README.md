# work-slices

Pomodoro Timer for Elementary OS

## Building, Testing, and Installation

You'll need the following dependencies to build:
* libgtk-3-dev
* meson
* valac

Run `meson build` to configure the build environment and run `ninja` to build
```Bash
    meson build --prefix=/usr
    cd build
    ninja
```
To install, use `ninja install`, then execute with `com.colinkiama.work-slices`
```Bash
    sudo ninja install
    com.github.colinkiama.work-slices
```
