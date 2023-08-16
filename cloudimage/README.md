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
virt-customize -a image.qcow2 --install qemu-guest-agent --selinux-relabel
```

bisa juga menginstall package lain seperti nginx, nano, vim dan lain-lain dengan cara seperti dibawah ini.
- Install qemu-guest-agent and etc
```sh
virt-customize -a image.qcow2 --install qemu-guest-agent,nginx,nano --selinux-relabel
```

bisa juga menginstall package lain dan juga install docker melalui bash script dengan cara seperti dibawah ini.
- Install qemu-guest-agent, etc and docker bash script
```sh
virt-customize -a image.qcow2 --install qemu-guest-agent,nginx,nano --run install-docker.sh ----firstboot-command 'dockerd &' --selinux-relabel
```

bisa juga menyisipkan script yang ingin dijalankan ketika pertama kali boot, misalnya script untuk merubah permisson login SSH dan juga `dockerd &` seperti dibawah ini.
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
virt-customize -a image.qcow2 --install qemu-guest-agent,nginx,nano --run install-docker.sh --upload hlp_init.sh:/root/ --firstboot-command 'sh /root/hlp_init.sh' --selinux-relabel
```

*Catatan:*

*`--selinux-relabel` hanya di butuhkan jika image yang ingin di custom adalah image dari turunan RedHat(CentOS, Alma Linux, Rocky Linux) jika Option `--selinux-relabel` tidak disertakan pada saat custom image biasanya VM tidak akan bisa booting.*

*install-docker.sh bisa di dapatkan dari url `get.docker.com` dan ketika install docker kedalam image, diperlukan command `dockerd &` ketika VM pertama kali boot agar docker yang sudah di install bisa berjalan saat pertama kali boot*

*Dokumentasi lain tentang `virt` bisa dibaca disini:*
https://docs.openstack.org/id/image-guide/modify-images.html#virt-tools

## Template
ketika image sudah selesai di custom berarti image sudah siap untuk dibuat template, untuk membuat template bisa menggunakan script `template.sh` yang sudah ada dilama repo ini dan ada beberapa variable yang perlu disesuaikan seperti berikut ini

|Key|Value|Description|
|---|---|---|
|VMID|9000|harus diperhatikan VMID tidak boleh sama dengan VMID yang sudah ada di dalam Proxmox dan range VMID yang dapat digunakan ada di angka 100-100000000|
|TEMPLATE_NAME|ubuntu-server-2204-docker-vm01|nama template yang ingin di set ke dalam proxmox
|IMAGE_NAME|ubuntu-22.04-minimal-cloudimg-amd64.qcow2|nama file image yang ingin di import menjadi template ke Proxmox

## Other Resources


***Youtube will be coming soon*** 😅<br>
***On Progress*** 👋