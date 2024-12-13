## Current Fedora config

### 1) Grub + TTY 

/etc/default/grub

`# sudo grub2-mkconfig -o /boot/grub2/grub.cfg`

/etc/vconsole.conf

`# sudo dnf install terminus-fonts-console`

### 2) Automount Readyshare

Create /mnt/readyshare/

[Unit files]

/etc/systemd/system/mnt-readyshare.mount 

/etc/systemd/system/mnt-readyshare.automount

`# systemctl daemon-reload`

`# systemctl enable mnt-readyshare.automount`

### 3) Codecs (minimal)

https://rpmfusion.org/Configuration

https://rpmfusion.org/Howto/Multimedia

Add repositories `rpmfusion-free` & `rpmfusion-free-updates`

Test hardware acceleration for h264/h265 with `nvtop`

### 4) Extension manager
- Dash to Panel
- Disable workspace switcher overlay
- Rounded Window Corners Reborn
- User Themes
- Vitals
- Workspace Indicator
  
#### Optional
- Color Picker
- Hide top bar
- OpenWeather Refined
- Tiling Shell

### 6) UI theme tweaks

Requires User Themes extension 

~/.config/gtk-4.0/gtk.css

~/.themes/litemotiv/gnome-shell/gnome-shell.css

### 5) Audio scripts

Join separate FLAC files into single FLAC

`# shntool join *.flac -o flac`

Embed CUE file into flac

`# metaflac --import-cuesheet-from="album.cue" --set-tag-from-file="CUESHEET=album.cue" "album.flac"`
