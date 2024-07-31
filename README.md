## My current Fedora config

#### 1) Extension manager
- Blur my shell
- Dash to dock
- Task widget
- Vitals
- OpenWeather Refined
- User themes (opt)

#### 2) Automount Readyshare

Create /mnt/readyshare/

[Unit files]

/etc/systemd/system/mnt-readyshare.mount 

/etc/systemd/system/mnt-readyshare.automount

`# systemctl daemon-reload`

`# systemctl enable mnt-readyshare.automount`

#### 3) Terminal Padding

~/.config/gtk-3.0/gtk.css

#### 4) Grub + TTY 

/etc/default/grub

`# sudo grub2-mkconfig -o /boot/grub2/grub.cfg`

/etc/vconsole.conf

`# sudo dnf install terminus-fonts-console`
