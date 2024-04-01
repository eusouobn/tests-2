#!/bin/bash
echo arch > /etc/hostname;
yes arch | passwd root;

useradd -m -g users -G wheel arch;
yes arch | passwd arch;

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime;
echo "pt_BR.UTF-8 UTF-8" > /etc/locale.gen;
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf;
hwclock --systohc;
locale-gen;

echo 'Server=https://mirror.ufscar.br/archlinux/'$'$repo/os/'$'$arch' > /etc/pacman.d/mirrorlist;

echo 'Server=https://mirror.ufscar.br/archlinux/'$'$repo/os/'$'$arch' > /etc/pacman.d/mirrorlist-arch;

echo "alias i='yay -S --noconfirm'
alias d='sudo pacman -Rsc'
alias nano='sudo nano'
alias addsuporte-bluetooth='yay -S --noconfirm bluez bluez-tools bluez-utils blueman && sudo systemctl start bluetooth.service && sudo systemctl enable bluetooth.service'
sudo rm -rf ~/.bash_history;
sudo rm -rf ~/.cache;
sudo pacman -Syyu --noconfirm;
sudo pacman -Scc --noconfirm;
clear;
fastfetch
git clone https://aur.archlinux.org/yay.git && sudo chmod 777 yay && cd yay && makepkg -si --noconfirm && cd ..; sudo rm -rf yay; yay -S --noconfirm google-chrome lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader vulkan-validation-layers lib32-vulkan-validation-layers vulkan-tools lib32-vulkan-tools vulkan-mesa-layers lib32-vulkan-mesa-layers vulkan-headers mesa-vdpau lib32-mesa-vdpau libva-mesa-driver lib32-libva-mesa-driver --save --answerdiff None --answerclean None --removemake; sed -i '$ d' /home/arch/.bashrc" > /home/arch/.bashrc;

echo "[options]
HoldPkg=pacman glibc
Architecture=auto
CheckSpace
ParallelDownloads=2
SigLevel=Required DatabaseOptional
LocalFileSigLevel=Optional
[core]
Include=/etc/pacman.d/mirrorlist
[extra]
Include=/etc/pacman.d/mirrorlist
[multilib]
Include=/etc/pacman.d/mirrorlist
[community]
Include=/etc/pacman.d/mirrorlist-arch" > /etc/pacman.conf;

sed -i '/^#/d' /etc/fstab;
sed -i '/^$/d' /etc/fstab;
sed -i 's/\(.rw.\)/\1noatime,/' /etc/fstab;

sed -i '/^#/d' /home/arch/.bash_profile;
sed -i '/^$/d' /home/arch/.bash_profile;

sed -i '/^#/d' /home/arch/.bash_logout;
sed -i '/^$/d' /home/arch/.bash_logout;

pacman -Syyu --noconfirm;

pacman -S git mesa fastfetch intel-ucode amd-ucode gnome pipewire pipewire-pulse pipewire-media-session pavucontrol --noconfirm;

pacman -S gdm --noconfirm;
systemctl enable gdm;

pacman -S sudo --noconfirm;
echo "arch ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers;
sed -i '/^#/d' /etc/sudoers;
sed -i '/^$/d' /etc/sudoers;

pacman -S networkmanager --noconfirm;
systemctl enable NetworkManager;
systemctl disable NetworkManager-wait-online;
systemctl disable systemd-timesyncd;

pacman -S grub-efi-x86_64 efibootmgr --noconfirm;
mkinitcpio -P;
grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=z --recheck;
sed -i '/^#/d' /etc/default/grub;
sed -i '/^$/d' /etc/default/grub;
sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=/g' /etc/default/grub;
sed -i 's/GRUB_DEFAULT=.*/GRUB_DEFAULT=-1/g' /etc/default/grub;
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=/g' /etc/default/grub;
sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/g' /etc/default/grub;
sed -i 's/GRUB_DISTRIBUTOR="[^"]*"/GRUB_DISTRIBUTOR=""/g' /etc/default/grub;
sed -i 's/GRUB_DISTRIBUTOR="/&z/g' /etc/default/grub;
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*"/GRUB_CMDLINE_LINUX_DEFAULT=""/g' /etc/default/grub;
sed -i 's/\(GRUB_CMDLINE_LINUX_DEFAULT="[^"]*\)"/\1quiet mitigations=off"/' /etc/default/grub;
grub-mkconfig -o /boot/grub/grub.cfg;
