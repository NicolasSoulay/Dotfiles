# Dotfiles

## Keyboard function key

```bash
sudo touch /etc/modprobe.d/hid_apple.conf
echo options hid_apple fnmode=2 >> /etc/modprobe.d/hid_apple.conf
sudo update-initramfs -u -k all
```
