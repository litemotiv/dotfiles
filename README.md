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

#### 2.1) Rsync backup

`# rsync -i -u -n -r --delete --stats /mnt/readyshare/[src]/ /run/media/[user]/[drive]/[dest]`

**Note**: trailing slash after src directory

```
-i        Output a change-summary for all updates
-u        Skip files that are newer on the receiver
-n        Dry-run
-r        Recurse into directories
--delete  Delete extraneous files from dest dirs
--stats   Give some file-transfer stats
```

### 3) Codecs (minimal)

https://rpmfusion.org/Configuration

https://rpmfusion.org/Howto/Multimedia

Add repositories `rpmfusion-free` & `rpmfusion-free-updates`

```
# sudo dnf swap ffmpeg-free ffmpeg --allowerasing
# sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
# sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
# sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld
```

### 4) Extension manager
- Dash to Panel
- Disable Workspace Animation
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

Remove CUE file from flac

`# metaflac --remove-all-tags album.flac`

### 6 Sudo asterisks
visudo
`Defaults env_reset,pwfeedback`

### 7 EU keyboard layout

![EU keyboard layout](https://blog.getreu.net/20201002-international-EurKEY-US-keyboard-layout-Debian/layout.png)
