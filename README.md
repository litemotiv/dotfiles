## Current Fedora config

### 1) Kernel / grub 

Disable Asus `fn-lock` on boot

Edit `/etc/default/grub`
```
GRUB_CMDLINE_LINUX="rhgb quiet asus_wmi.fnlock_default=0"
```
Regenerate grub.cfg
```
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

### 2) Automount Readyshare

Create `/mnt/readyshare/`

Add `/etc/systemd/system/mnt-readyshare.mount`

Add `/etc/systemd/system/mnt-readyshare.automount`

```
sudo systemctl daemon-reload
```
```
sudo systemctl enable mnt-readyshare.automount
```

#### 2.1) Rsync backup

Sync command with dry-run:
```
rsync -i -u -n -r --delete --stats /mnt/readyshare/[src]/ /run/media/[user]/[drive]/[dest]
```

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
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
```
```
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
```
```
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
```
```
sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld
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

Add `~/.config/gtk-4.0/gtk.css`

Add `~/.themes/litemotiv/gnome-shell/gnome-shell.css`

### 5) Audio scripts

Join separate FLAC files into single FLAC

```
shntool join *.flac -o flac
```

Embed CUE file into flac

```
metaflac --import-cuesheet-from="album.cue" --set-tag-from-file="CUESHEET=album.cue" "album.flac"
```

Remove CUE file from flac

```
metaflac --remove-all-tags album.flac
```

Convert audio to 16/44

Add `~/.local/bin/convert.sh`

Generate cue files from Discogs

Add `/usr/local/bin/dcue`

### 7 Miscellaneous

Disable Gnome suspend notifications
```
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
```

Double TTY font size
```
setfont -d
```

Show asterisks when typing sudo passwords

Run `visudo`

```
Defaults env_reset,pwfeedback
```
