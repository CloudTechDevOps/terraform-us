module "dev" {
    # source = "github.com/CloudTechDevOps/terraform-us/day-4-modules"
    ami_id = "ami-01376101673c89611"
    instance_type = "t2.micro"
    key = "public"
    

}