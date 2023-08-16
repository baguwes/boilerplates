# Terraform

Official Instruction Install [Terrafrom](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)

>Ubuntu/Debian<br>
>```
>wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
>echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
>sudo apt update && sudo apt install terraform
>```

>CentOS/RHEL
>```
>sudo yum install -y yum-utils
>sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
>sudo yum -y install terraform
>```

## Telmate/proxmox
Official Dokumentasi [Telmate/proxmox](https://github.com/Telmate/terraform-provider-proxmox/tree/master)<br>
Provider [Telmate/proxmox](https://registry.terraform.io/providers/Telmate/proxmox)

## hashicorp/dns
Official Dokumentasi [hashicorp/dns](https://github.com/hashicorp/terraform-provider-dns)<br>
Provider [hashicorp/dns](https://registry.terraform.io/providers/hashicorp/dns)


## Other Resources


***Youtube will be coming soon*** 😅<br>
***On Progress*** 👋