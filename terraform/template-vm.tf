resource "proxmox_vm_qemu" "demo" {
    name = "demo.demodomain.com"
    desc = "demo"
    target_node = "vm01"
    vmid = "5000"

    agent = 1
    
    qemu_os = "other"
    clone = "ubuntu-server-2204-docker-vm01"
    cores = 1
    sockets = 1
    cpu = "host"
    memory = 2048

    oncreate = true
    onboot = true
    startup = "order=4,up=10"

    os_type = "cloud-init"
    ipconfig0 = "ip=192.168.0.222/24,gw=192.168.0.1"
    nameserver = "192.168.0.3"
    ciuser = "demo"
    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDmvdcAkYj6yO1142tPVgITgKMZdppv3PYHoKZAkWfDYmOwOvdFKGcO53FpNPWFgOI7ZuWqWGQNp3oyrkxQu+XQElSTB1hhnxuFTwKA/QtAYLX6+IJJOFCZxnhDdf/FRbARbCRxliCpV54LVAJPrlKJlXuB1lqvwjz58gLMwZgOvL/whTBpg3D4RedGYOZlC7S2qwtJiyR6qCLvUvlzVu122CPl2athrY15Seb70IIgc8J44RLNc0C+7/BdJrMqD9He+105vx2+ry/5Vb9OE+wD3lUnMWLsSXpvuKMqyVcpgvoqr78Zd4ZaEk8fF9+KpAPQHiDXNyMy5BBvbIBuGdBMCr83ju19TitHkUAhLSZn3SKTyYCs7RoYF3ZKyHM8JAzQY0O6vzboyICRb9cdW+LT8TeY21OMRtB21hC7riysqyj+ZsP506F7XgWQfKy0onX6I1kOOLOaJ/dox9yfpeQ3iHhVuxkWzlwd/gBYI70ZJznFIXnjAfFsp9XCFq5KGvE= spesolution\bagos.rinaldi@DESKTOP-CI7NBLO
    EOF

  network {
    bridge = "vmbr0"
    model = "virtio"
    }

  disk {
    storage = "diskSSD"
    type = "virtio"
    size = "32G"
    }

  lifecycle {
    ignore_changes = [
    disk,
    ]
  }
}