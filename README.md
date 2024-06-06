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
