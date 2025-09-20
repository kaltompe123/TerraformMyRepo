module "prod" {
  source = "github.com/CloudTechDevOps/terraform0730am/Day-9-modules/"
  ami_id ="ami-00ca32bbc84273381"
  az ="us-east-1a"
  instance_type = "t3.micro"
  
}