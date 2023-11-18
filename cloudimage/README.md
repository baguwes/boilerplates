# Template Proxmox

## List Download Cloud Image
[Ubuntu](http://cloud-images.ubuntu.com/releases/)

[Rocky Linux](https://rockylinux.org/alternative-images)

[Alma Linux](https://repo.almalinux.org/almalinux/)


## Prequestion
- Install libguestfs-tools on Proxmox server

```sh
apt install libguestfs-tools libvirt-clients virtinst
```
diperlukan untuk menjalankan perintah `virt-*`, `virsh`, kalo sudah ada bisa di skip dan lanjut ke command di bawah.

## Custom Image
Secara Default image yang di download biasanya belum ada qemu-guest-agent, untuk meng-custom image agar pre-installed qemu-guest-agent bisa menggunakan command dibawah.
- Install qemu-guest-agent
```sh
virt-customize -a IMAGE_FILE --install qemu-guest-agent --selinux-relabel
```

bisa juga menginstall package lain seperti nginx, nano, vim dan lain-lain dengan cara seperti dibawah ini.
- Install qemu-guest-agent and etc
```sh
virt-customize -a IMAGE_FILE --install qemu-guest-agent,nginx,nano --selinux-relabel
```

bisa juga menginstall package lain dan juga install docker melalui bash script dengan cara seperti dibawah ini.
- Install qemu-guest-agent, etc and docker bash script
```sh
curl -fsSL https://get.docker.com -o install-docker.sh

virt-customize -a IMAGE_FILE --install qemu-guest-agent,nginx,nano --run install-docker.sh ----firstboot-command 'dockerd &' --selinux-relabel
```

bisa juga menyisipkan bash script yang ingin dijalankan ketika pertama kali boot, misalnya script untuk merubah permisson login SSH dan juga `dockerd &` seperti dibawah ini.
```sh
#!/bin/sh

# Mengizinkan login SSH dengan user root
sed -i "s/.*PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
# Mengizinkan login dengan SSH password
sed -i "s/PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
service sshd restart

# Jika Image pre-installed docker, perintah di bawah perlu untuk di jalankan ketika pertama kali boot
dockerd &
```
untuk membuat script ini di execute kita butuh command tambahan seperti `--upload` agar script yang kita ingin jalankan ketika pertama kali boot tidak mendapatkan error *hlp_init.sh Not Found*
- Install qemu-guest-agent, etc and docker bash script with firstboot command
```sh
virt-customize -a IMAGE_FILE --install qemu-guest-agent,nginx,nano --run install-docker.sh --upload hlp_init.sh:/root/ --firstboot-command 'sh /root/hlp_init.sh' --selinux-relabel
```

*Catatan:*

*`--selinux-relabel` hanya di butuhkan jika image yang ingin di custom adalah image dari turunan RedHat(CentOS, Alma Linux, Rocky Linux) jika Option `--selinux-relabel` tidak disertakan pada saat custom image biasanya VM tidak akan bisa booting.*

*install-docker.sh bisa di dapatkan dari url `get.docker.com` dan ketika install docker kedalam image, diperlukan command `dockerd &` ketika VM pertama kali boot agar docker yang sudah di install bisa berjalan saat pertama kali boot*

*Dokumentasi lain tentang `virt` bisa dibaca disini:*
https://docs.openstack.org/id/image-guide/modify-images.html#virt-tools

## Template
ketika image sudah selesai di custom berarti image sudah siap untuk dibuat template, untuk membuat template bisa menggunakan script `template.sh` yang sudah ada dilama repo ini dan ada beberapa variable yang perlu disesuaikan seperti berikut ini

|Key|Value|Description|
|---|---|---||VMID|9000|harus diperhatikan VMID tidak boleh sama dengan VMID yang sudah ada di dalam Proxmox dan range VMID yang dapat digunakan ada di angka 100-100000000|
|TEMPLATE_NAME|ubuntu-server-2204-docker-vm01|nama template yang ingin di set ke dalam proxmox
|IMAGE_NAME|ubuntu-22.04-minimal-cloudimg-amd64.qcow2|nama file image yang ingin di import menjadi template ke Proxmox

## Resize Image
kadang kita butuh untuk melakukan Resize Image, tujuannya agar image yang ingin kita custom memiliki cukup storage untuk di install package seperti docker dan lain-lain.

tidak seperti centos yang secara default di set 8GB, karna cloud image ubuntu default storage-nya 2GB, biasanya kita akan mendapatkan error
```error
No apport report written because the error message indicates a disk full error
E: Sub-process /usr/bin/dpkg returned an error code (1)
virt-customize: error: install-docker.sh: command exited with an error

If reporting bugs, run virt-customize with debugging enabled and include 
the complete output:

  virt-customize -v -x [...]
```
error ini disebabkan karna storage cloud image ubuntu tidak cukup untuk melakukan pre-installed docker, di bawah ada beberapa step yang bisa dilakukan sebelum melakukan pre-install docker di ubuntu.

Resize Image Ubuntu ke 4GB<br>
*Jika 4GB dirasa kurang bisa disesuaikan dengan kubutuhan*
```sh
qemu-img resize ubuntu-22.04-server-cloudimg-amd64.img 4G
```
```sh
Output:

Image resized.
```
Set Partisi sampai 10 untuk kebutuhan mount
```sh
modprobe nbd max_part=10
```
Command Mount/Connected Image Ubuntu ke /dev/nbd0
```sh
qemu-nbd -c /dev/nbd0 ubuntu-22.04-server-cloudimg-amd64.img
```
Command untuk masuk ke menu parted /dev/nbd0
```sh
parted /dev/nbd0
```
```sh
Output:

GNU Parted 3.4
Using /dev/nbd0
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted)        
```
Untuk memastikan ukuran disk sebelum di resize
```sh
print
```
Jika keluar output seperti Output 1, isi saja `Fix` lalu Enter, setelah itu akan keluar Output 2
```sh
Output 1:

Warning: Not all of the space available to /dev/nbd0 appears to be used, you can fix the GPT to use all of the space (an extra 3776512 blocks) or continue with the current
setting? 
Fix/Ignore? Fix


Output 2:

Model: Unknown (unknown)
Disk /dev/nbd0: 4295MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
14      1049kB  5243kB  4194kB                     bios_grub
15      5243kB  116MB   111MB   fat32              boot, esp
 1      116MB   2361MB  2245MB  ext4
```
Ini adalah command untuk menambahkan semua alokasi disk yang tidak terpakai ke partisi 1
```sh
resizepart 1 100%
```
Untuk memastikan ukuran disk setelah di resize
```sh
print
```
```sh
Output:

Model: Unknown (unknown)
Disk /dev/nbd0: 4295MB
Sector size (logical/physical): 512B/512B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
14      1049kB  5243kB  4194kB                     bios_grub
15      5243kB  116MB   111MB   fat32              boot, esp
 1      116MB   4295MB  4179MB  ext4
```
Command untuk keluar dari parted
```sh
quit
```
Command untuk melakukan Filsesystem Check sebelum di Resize
```sh
e2fsck -f /dev/nbd0p1
```
```sh
Output:

e2fsck 1.46.5 (30-Dec-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
cloudimg-rootfs: 73614/274176 files (0.0% non-contiguous), 400571/548091 blocks
```
Command untuk apply Resize Filesystem
```sh
resize2fs /dev/nbd0p1
```
```sh
Output:

resize2fs 1.46.5 (30-Dec-2021)
Resizing the filesystem on /dev/nbd0p1 to 1020155 (4k) blocks.
The filesystem on /dev/nbd0p1 is now 1020155 (4k) blocks long.
```
Command untuk Unmount/Disconnected Image Ubuntu dari /dev/nbd0
```sh
qemu-nbd -d /dev/nbd0
```
```sh
Output:

/dev/nbd0 disconnected
```

sekarang Image Ubuntu sudah berhasil di Resize dan bisa di coba untuk melakukan pre-install docker ke Image Ubuntu.
