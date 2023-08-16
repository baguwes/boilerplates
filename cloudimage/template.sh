#!/usr/bin/env bash
VMID="VMID"
TEMPLATE_NAME="TEMPLATE_NAME"
IMAGE_NAME="IMAGE_NAME"

# Create a new VM with ID VMID
qm create $VMID --name $TEMPLATE_NAME --memory 1024 --net0 virtio,bridge=vmbr0

# Import the downloaded disk to local storage with qcow2 format
qm importdisk $VMID $IMAGE_NAME local --format qcow2

# Attach the new disk to the VM as scsi drive
qm set $VMID --scsihw virtio-scsi-pci --scsi0 local:$VMID/vm-$VMID-disk-0.qcow2

# Add Cloud-Init CDROM drive
qm set $VMID --ide2 local:cloudinit

# Speed up booting by setting the bootdisk parameter
qm set $VMID --boot c --bootdisk scsi0

# Configure a serial console for display
qm set $VMID --serial0 socket --vga serial0

# Enable the guest agent
qm set $VMID --agent enabled=1

# Convert the VM into a template
qm template $VMID