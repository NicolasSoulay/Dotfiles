# Dotfiles

## Keyboard function key

```bash
sudo touch /etc/modprobe.d/hid_apple.conf
echo options hid_apple fnmode=2 >> /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all
```

## Keyboard layout

```bash
sudo dpkg-reconfigure keyboard-configuration
```

Select "English (US) - English (intl., with AltGr dead keys)"
alt right for AltGr
no compose key

```bash
service keyboard-setup restart
```

reboot

## Disable Screensaver

To fully disable:

```conf
/etc/X11/xorg.conf.d/10-extensions.conf

Section "Extensions"
    Option "DPMS" "false"
EndSection

```

To change the delay before screen saving:

```conf
/etc/X11/xorg.conf.d/10-serverflags.conf

Section "ServerFlags"
    Option "StandbyTime" "10"
    Option "SuspendTime" "20"
    Option "OffTime" "30"
EndSection

```

## TuiGreet

To disable startup message inside the greeter:

```conf
/etc/sysctl.d/20-quiet-printk.conf

kernel.printk = 3 3 3 3
```

Configuration:

```toml
/etc/greetd/config.toml

[terminal]
vt = 7

[default_session]
command = "tuigreet -r --asterisks --cmd startx"
user = "_greetd"
```
