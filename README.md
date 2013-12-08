WebP QuickLook Plugin
=====================

This is an open-source QuickLook plugin to generate thumbnails and previews for [WebP images](http://code.google.com/speed/webp/). Requires Mac OS X 10.7 or later (but tested on 10.8).

New version supports WebP lossy, lossless, and alpha channels.


Installation
------------

Click [Releases](https://github.com/dchest/webp-quicklook/releases) and download the latest version. Unzip it, and put `WebP.qlgenerator` into `~/Library/QuickLook` (or `/Library/QuickLook`). You may need to reboot to enable it (or open Terminal and run `qlmanage -r`).


Development Notes
-----------------

The plugin uses the precompiled `libwebp.a` (i386, x86\_64; git rev. 2afee60a7) located in `lib`. I build it manually, and haven't yet created a script to build it from sources; patches welcome.
