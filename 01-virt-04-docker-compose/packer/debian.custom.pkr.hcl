# packer build debian.custom.pkr.hcl
# export YC_TOKEN=$(yc iam create-token)
# export YC_FOLDER_ID=$(yc config get folder-id)
# export YC_ZONE=$(yc config get compute-default-zone)

variable "YC_FOLDER_ID" {
  type    = string
  default = env("YC_FOLDER_ID")
}

variable "YC_SUBNET_ID" {
  type    = string
  default = "e2l6fsfq6dvfcun3sc60"
}

variable "YC_ZONE" {
  type    = string
  default = env("YC_ZONE")
}

source "yandex" "yc-debian-custom" {
  folder_id               = "${var.YC_FOLDER_ID}"
  source_image_family     = "debian-11"
  ssh_username            = "debian"
  temporary_key_pair_type = "ed25519"
  use_ipv4_nat            = "true"
  image_description       = "Yandex Cloud Debian Custom image"
  image_family            = "custom-images"
  image_name              = "yc-debian-custom"
  subnet_id               = "${var.YC_SUBNET_ID}"
  disk_type               = "network-hdd"
  zone                    = "${var.YC_ZONE}"
}

build {
  sources = ["source.yandex.yc-debian-custom"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y unzip python3-pip",
      "sudo apt-get install -y git jq tree",
#      # Docker
#      "sudo apt-get install -y ca-certificates curl gnupg",
#      "sudo install -m 0755 -d /etc/apt/keyrings",
#      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
#      "sudo chmod a+r /etc/apt/keyrings/docker.gpg",
#      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
#      "sudo apt-get update",
#      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
#      "sudo chmod 666 /var/run/docker.sock",
#      "sudo usermod -aG docker $USER",
      # Test - Check versions for installed components
      "echo '=== Tests Start ==='",
#      "docker version",
#      "sudo docker run hello-world",
      "git --version",
      "jq --version",
      "tree --version",
      "echo '=== Tests End ==='"
    ]
  }
}