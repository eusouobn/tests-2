#!/bin/bash




devices_list=$(lsblk -dlnp -I 2,3,8,9,22,34,56,57,58,65,66,67,68,69,70,71,72,91,128,129,130,131,132,133,134,135,259 | awk '{print $1,$4,$6,$7}' | column -t)

devices_select=$(lsblk -nd --output NAME | grep 'sd\|hd\|vd\|nvme\|mmcblk')

printf '\x1bc';
PS3=$'\nSelecione uma opção: ';
echo -e "Lista de Dispositivos:"
echo -e "\n"
echo -e "Nome - Tam. - Tipo"
echo -e "$devices_list"
echo -e "\n"
echo -e 'Escolha um Disco para Instalar o Sistema: '
select installdisk in $devices_select; do
echo "/dev/$installdisk";
break

done


echo "o
w" | fdisk /dev/installdisk;

# 1GB BIOS Boot
echo "n
p
1

+1G
t
4
w" | fdisk /dev/installdisk;

# 20GB raiz
echo "n
p
2

+20G
t
2
83
w" | fdisk /dev/installdisk;

# restante HD
echo "n
p
3


w" | fdisk /dev/installdisk;

mkfs.fat -F32 /dev/installdisk1;
mkfs.ext4 -F /dev/installdisk2;
mkfs.ext4 -F /dev/installdisk3;

mount /dev/installdisk2 /mnt;

mkdir /mnt/boot;
mkdir /mnt/boot/EFI;
mkdir /mnt/home;

mount /dev/installdisk1 /mnt/boot/EFI;
mount /dev/installdisk3 /mnt/home;

pacstrap /mnt base base-devel linux linux-firmware;

genfstab -U -p /mnt >> /mnt/etc/fstab;

mv AutoArch/e2.sh ~;
chmod 777 e2.sh;
cp e2.sh /mnt;
arch-chroot /mnt /e2.sh;

reboot;
