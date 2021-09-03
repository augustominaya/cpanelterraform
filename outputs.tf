
//show the private ip of the web public
output "PublicIP" {
    value = module.ec2_module.pub_ip
}

