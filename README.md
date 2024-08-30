## My current Fedora config

### 1) Extension manager

- Disable workspace switcher overlay 
- Task widget
- Tiling Shell
- Vitals
- OpenWeather Refined

#### Optional
- Blur my shell
- Dash to dock
- V-Shell (Vertical Workspaces)
- No overview at start-up
- User themes

### 2) Automount Readyshare

Create /mnt/readyshare/

[Unit files]

/etc/systemd/system/mnt-readyshare.mount 

/etc/systemd/system/mnt-readyshare.automount

`# systemctl daemon-reload`

`# systemctl enable mnt-readyshare.automount`

### 3) Grub + TTY 

/etc/default/grub

`# sudo grub2-mkconfig -o /boot/grub2/grub.cfg`

/etc/vconsole.conf

`# sudo dnf install terminus-fonts-console`

### 4) Codecs (minimal)

https://rpmfusion.org/Configuration

https://rpmfusion.org/Howto/Multimedia

Add repositories `rpmfusion-free` & `rpmfusion-free-updates`

Test hardware acceleration for h264/h265 with `nvtop`

### 5) Apps Library
| Name | Source |
| --- | --- |
| AmiBerry | Flathub |
| Apostrophe | Flathub |
| Calibre | RPM |
| EarTag | Flathub |
| Extension Manager | Flathub |
| Flameshot | RPM |
| Flatseal | Flathub |
| Gnome Tweaks | RPM |
| MusicBrainz Picard | RPM |
| Nicotine+ | RPM |
| qBittorrent | Flathub |
| Switcheroo | Flathub |
| Tauon | Flathub |
| Ptyxis Terminal | RPM |
| Vice | Flathub |
| VLC | Flathub |

#### Console ####
| Name | Source |
| --- | --- |
| htop | RPM |
| nvtop | RPM |
| rpmreaper | RPM |
| vim-enhanced | RPM |

