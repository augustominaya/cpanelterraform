
variable "instance_id"{
    type = string
}

//elastic ip to assing to the webserver
resource "aws_eip" "web_ip" {
    instance = var.instance_id
}

//show the private ip of the web public
output "PublicIP" {
    value = aws_eip.web_ip.public_ip
}