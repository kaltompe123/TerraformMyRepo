terraform {
  backend "s3" {
    bucket = "my-kt-infra-state-bucket"
    key = "test/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true 
  }
}