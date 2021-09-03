
variable "ami_id" {
  description = "AMI ID to be used for Instance "
  default     = "ami-09e67e426f25ce0d7"
}

variable "instancetype" {
  description = "Instance Typebe used for Instance "
  default     = "t2.micro"
}

variable "subnetid" {
  description = "Subnet ID to be used for Instance "
  default     = "subnet-2eeae963"
}

variable "aws_key" {
  description = "aws key to connect to the server"
  default     = "Terraform_key"
}

variable "nameserver" {
  description = "Name Server"
  default     = "cpanel-20_04-cloud"
}

resource "aws_instance" "web_server" {
  ami                    = var.ami_id
  instance_type          = var.instancetype
  key_name               = var.aws_key
  subnet_id              = var.subnetid
  //security_groups = [module.sg_module.sg_name]
  vpc_security_group_ids = [module.sg_module.sg_name]

  //user_data = "${file("userdata.sh")}"

  tags = {
   Name = "${var.nameserver}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

output "pub_ip" {
    value = module.eip.PublicIP
}

//elastic ip module
module "eip"{
    source = "../eip"
    instance_id = aws_instance.web_server.id
}
//security group module
module "sg_module"{
    source = "../security_group"
}


