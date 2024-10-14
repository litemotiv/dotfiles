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

- Disable workspace switcher overlay
- Hide top bar 
- Task widget
- Tiling Shell
- Vitals

#### Optional
- OpenWeather Refined
- Blur my shell
- Dash to dock
- V-Shell (Vertical Workspaces)
- No overview at start-up
- User themes

### 5) Apps Library
| Name | Source |
| --- | --- |
| AmiBerry | Flathub |
| Apostrophe | Flathub |
| Calibre | RPM |
| draw.io | Flathub |
| EarTag | Flathub |
| Extension Manager | Flathub |
| Flameshot | RPM |
| Flatseal | Flathub |
| FreeFileSync | Flathub |
| Gnome Tweaks | RPM |
| kitty | RPM |
| MusicBrainz Picard | RPM |
| Nicotine+ | RPM |
| Obsidian | Flathub |
| qBittorrent | Flathub |
| Raspberry Pi Imager | Flathub |
| Switcheroo | Flathub |
| Tauon | Flathub |
| Ptyxis | RPM |
| Vice | Flathub |
| VLC | Flathub |
| Zed | Flathub |
| Zen Browser | Flathub |

#### Console ####
| Name | Source |
| --- | --- |
| htop | RPM |
| ncmpc | RPM |
| nvtop | RPM |
| rpmreaper | RPM |
| shntool | RPM |
| vim-enhanced | RPM |

### 6) Audio scripts

Join separate FLAC files into single FLAC

`# shntool join *.flac -o flac`

Embed CUE file into flac

`# metaflac --import-cuesheet-from="album.cue" --set-tag-from-file="CUESHEET=album.cue" "album.flac"`
