module "myec2"{
  source = "../ec2-module"
  sg_name = var.sg_name
  instancetype = var.instancetype
  key_name = var.key_name
}