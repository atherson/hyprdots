<div align="center">

<p align="center">
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&color=A7C7E7&center=true&vCenter=true&width=435&lines=Welcome+to+Atherson's+Hyprdots;The+Ultimate+Arch+Experience;Dynamic+Theming+Enabled;Built+for+Performance" alt="Typing SVG" />
</p>

[![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-1793d1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org)
[![Hyprland](https://img.shields.io/badge/WM-Hyprland-33ccff?style=for-the-badge&logo=hyprland&logoColor=white)](https://hyprland.org)

<p align="center">
  <b>A sleek, automated, and highly customized Hyprland configuration for Arch Linux.</b><br>
  <i>Featuring dynamic "Wallbash" theming, smooth animations, and a modern workflow.</i>
</p>

---

<https://github.com/prasanthrangan/hyprdots/assets/106020512/7f8fadc8-e293-4482-a851-e9c6464f5265>

</div>

## 🚀 Features at a Glance

* **⚡ Blazing Fast:** Optimized for Arch Linux performance.
* **🎨 Wallbash:** System colors automatically sync with your wallpaper.
* **🧩 Modular:** Configurations are split for easy editing.
* **🎮 NVIDIA Support:** Pre-configured environment variables for green-team users.
* **🪄 Aesthetic:** Rounded corners, blurred surfaces, and custom Bezier curves.

---

#### **INSTALLING ARCH LINUX**

Ensure youve downloaded the iso from <https://archlinux.org/> and mounted the [```.iso```] to a flash drive.
Boot into the flash drive "live environment". You should see a prompt [```root@archiso```]. Now youre in the live environment!!!!!

Check if your connected to the internet. Ensure its stable. 
##### ****ARCH REQUIRES AN INTERNET CONNECTION TO DOWNLOAD ITS PACKAGES.****

**ETHERNET**: If you're on ethernet, it should be straight foward. Type in the following command ```ping archlinux.org```.


**WIFI**: If you're on wifi, run the following command ```iwctl```

- List your devices: ```device list``` (Usually, your device is named wlan0.)
- Turn on the scan: ```station wlan0 scan```
- List available networks: ```station wlan0 get-networks```
- Connect to your SSID: ```station wlan0 connect YOUR_NETWORK_NAME```
- **Tip: If you have a hidden SSID, the command is slightly different:**
    ```bash
      station wlan0 connect-hidden YOUR_NETWORK_NAME
    ```
- Enter password: It will prompt you for the passphrase. Type it in and hit Enter.
- Exit: Type exit or hit Ctrl+D to return to the standard root prompt.

- **To confirm your connection, ** Type in:
  ```bash
  ping -c 4 archlinux.org
  ```


---


## DISK CONFIGURATIONS
After connecting to the internet type in the following command to have a look at the partitions in your drives.

This is the most ****"dangerous"**** part. Identify your drive using ```fdisk -l```. Usually, it’s ```/dev/sda``` or ```/dev/nvme0n1```.

Use cfdisk ```/dev/sdX``` (replace X with your drive letter) to create:

EFI Partition: ~512MB (Type: EFI System)

Swap Partition: 4GB–8GB (Type: Linux swap)

Root Partition: Remainder of the space (Type: Linux root x86-64)

Format the partitions:

EFI: 
```bash
mkfs.fat -F 32 /dev/sdX1
```

Swap: 
```bash 
mkfs.swap /dev/sdX2
```
press enter. Followed by ```swapon /dev/sdX2``.

Root: 
```bash
mkfs.ext4 /dev/sdX3
```


---

## 🛠️ Mounting and Base Installation
Now we mount the root partition and install the core of the OS.

Mount Root: 
```bash 
mount /dev/sdX3 /mnt
```

Mount EFI: 
```bash
mount --mkdir /dev/sdX1 /mnt/boot
```

Install Base Packages:
```bash
pacstrap /mnt base linux linux-firmware nano grub efibootmgr networkmanager
```

---

## 🛠️ Configuring the System
Generate the filesystem table so your computer knows where your partitions are at boot.
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

You've now instaled archlinux base system. Lets now enter your system and configure it.


Enter the new system (Chroot):
```bash
arch-chroot /mnt
```

Let's now configure your newly installed system:

Inside the chroot, set your vitals:

Timezone: 
```bash
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```
eg: 
```bash
ln -sf /usr/share/Africa/Kenya/Nairobi /etc/localtime
```

Localization: Edit 
```bash
/etc/locale.gen
```
uncomment 
```bash
en_US.UTF-8 UTF-8
```
by removing ```#``` at the begining of the line, then run 
```locale-gen```.

Hostname: 
```bash
echo "what_you_want_to_name" > /etc/hostname
```

## 🔒 Root Password: Type 
```bash
passwd
```
and follow the prompts.


ADDING A USER:
 ```bash
 sudo useradd -m -G wheel -s /bin/bash username
``` 
 THEN 
 ```bash
 sudo passwd username
```
to give the new user a password. **Optional**, this is to give the user ```sudo``` privileges 
```bash 
sudo EDITOR=nano visudo
```
then uncomment the line ```%wheel ALL=(ALL) ALL```.     

---

## 🛠️ Bootloader and Networking.
Without a bootloader, your BIOS won't know Arch exists.

Install GRUB:
```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
```

Generate Config:
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

Enable Internet on boot:
```bash
systemctl enable NetworkManager
```


## 6. The Finish Line
Exit the chroot, unmount, and reboot:

```bash
exit
umount -R /mnt
reboot
```


## 🛠️ Prerequisites & Installation

To get this environment running perfectly, follow these steps. We will start from a fresh Arch Linux install and chrooting into the newly installed system.

### 1. Install hyprland and extras.

```bash
Sudo pacman -S hyprland wayland wayland-protocols xorg-xwayland kitty sddm git
Sudo systemctl enable sddm.service
```
Now reboot the system.

---

### 2. Installing hyprdots.
Lets now edit your ```hyprland.conf```, Press Windows + Q to open the terminal and type in 
```bash
nano .config/hypr/hyprland.conf
```

Git is required to clone the repository.
```bash
sudo pacman -Syu             # Update your system first
sudo pacman -S git          # Install Git
```

Lets install **paru**, a package manager.
```bash
git clone https://aur.archlinux.org/paru.git
cd paru/
makepkg -si
```
Follow the instructions.

if it fails run this ``` Sudo pacman -S --needed base-devel```

---

## 📁 If there are no desktop, downloads, pictures .... directories, download and run this:
```bash
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update
```
---

### 2. Cloning the repository
Git is required to clone the repository.
```bash
git clone https://github.com/atherson/hyprdots
cd hyprdots/Scripts
./install.sh
```
Follow the instructions in the installer.
For your browser run this command after installing hyprdots:
```bash
sudo pacman -S flatpak
flatpak install com.brave.Browser
```
Then use Windows + F to open brave browser.

## ⌨️ Essential Keybindings
The default Modifier Key is `Super` (Windows Key).

| Action | Shortcut |
| :--- | :--- |
| **Terminal (Kitty)** | `Super` + `T` |
| **Web Browser (Brave)** | `Super` + `F` |
| **File Manager (Dolphin)** | `Super` + `E` |
| **Music (Spotify)** | `Super` + `B` |
| **Application Launcher** | `Super` + `A` |
| **Close Window** | `Super` + `Q` |
| **Toggle Floating** | `Super` + `W` |
| **Lock Screen** | `Super` + `L` |
| **Theme Selector** | `Super` + `Shift` + `T` |
| **Wallpaper Selector** | `Super` + `Shift` + `W` |
| **Screenshot (Area)** | `Super` + `P` |


💡 **Tip**: If trying to run the browser and isnt running, Or such an error pops out: 
```bash
bwrap: No permissions to creating new namespace, likely beacuse the kernel doesnt allow non-privileged user namespaces. On eg debian......
```
do this:

```bash
sudo nano /etc/sysctl.d/99-userns.conf
```
then add this: 
```bash
kernel.unprivileged_userns_clone=1
```
save and exit then apply with:
```bash
sudo sysctl --system
```
To verify run:
```bash
sysctl kernel.unprivieged_userns_clone
```
you should see:
```kernel.unprivileged_userns_clone = 1```


