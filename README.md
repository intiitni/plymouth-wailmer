plymouth-wailmer
===============

This is a Plymouth theme which gives you a spinning Wailmer as your Linux system boots. 

*(Note: This project is a direct adaptation of the excellent [plymouth-blåhaj](https://github.com/190n/plymouth-blahaj) theme. Almost the entire structure, workflow, and base theme were copied and modified from that repository.)*

## Usage

- Install by copying the `wailmer` directory to `/usr/share/plymouth/themes`.
- Follow your distribution's instructions for changing the theme. [On Arch](https://wiki.archlinux.org/title/Plymouth#Changing_the_theme) you need to:
	- change the `Theme` option in `/etc/plymouth/plymouthd.conf` to `wailmer`
	- run `plymouth-set-default-theme -R wailmer` as root. For me, this generates a _ton_ of warnings about UTF-8 filenames, but it does end up working.

	It's probably the same on other distros, but it's worth checking.

## Files

- `spinny.blend` is a Blender project containing the 3D model set up to spin around in a loop
- `frames` contains 4K renders of Wailmer in various orientations
- `wailmer` contains the theme itself, mostly copied from the default `spinner` theme except for the Wailmer images and name/description
- `scripts` contains a few scripts I used to generate the final images. Generally the workflow is to run `./scripts/crop.sh` and then `./scripts/fade.sh` from this repository. See comments in each script for more on what they do. You need Python 3, ffmpeg, GNU parallel, and optionally optipng (comment out the lines that call it if you don't want to use it).

## Credits & Acknowledgments

This project would not exist without [190n/plymouth-blahaj](https://github.com/190n/plymouth-blahaj). I almost completely copied their repository structure, rendering scripts, and theme base to make this work. Huge thanks to [@190n](https://github.com/190n) for creating the original Blåhaj theme and making it so straightforward to adapt for other models!