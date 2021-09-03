provider "aws"{
    region = "us-east-1"
}

//now we need to call the ec2 module
module "ec2_module"{
    source = "./ec2/"

}
