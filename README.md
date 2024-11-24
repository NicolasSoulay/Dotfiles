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

Reboot

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
