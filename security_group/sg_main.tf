
//port allow to conect to the webserver
variable "ingress" {
    type = list(number)
    default = [80, 443]
}

variable "egress" {
    type = list(number)
    default = [80, 443]
}

variable "HostIp" {
  description = " Host Public IP to be allowed SSH for"
  default     = "152.166.207.145/32"
}


variable "PvtIP" {
  description = " Host IP to be allowed SSH for"
  default     = "172.31.16.0/16"
}

//return the security group name to assing to the ec2 instance
output "sg_name"{
    value = aws_security_group.web_traffic.id
}

//security group allow trafic to the webserver
resource "aws_security_group" "web_traffic" {
    name = "Allow_WEB_Traffic"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["${var.HostIp}"]
    } 

        dynamic "ingress" {
        iterator = port
        for_each = var.ingress
        content{       
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
        }
    } 

    dynamic "egress" {
        iterator = port
        for_each = var.egress
        content{       
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = [ "0.0.0.0/0" ]
        }
    } 

}