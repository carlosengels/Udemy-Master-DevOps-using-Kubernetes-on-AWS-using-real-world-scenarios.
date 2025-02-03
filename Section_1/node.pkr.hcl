source "amazon-ebs" "ubuntu" {
    ami_name        = "k8s-node" "ubuntu"
    instance_type   = "t3.micro"
    region          = "us-east-2"
    source_ami_filter {
        filters = {
            name                    = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
            root-device-type        = "ebs"
            virtualization-type    = "hvm"
        }
        most_recent = true
    }
}