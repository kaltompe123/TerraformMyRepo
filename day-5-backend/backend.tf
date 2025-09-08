terraform {
  backend "s3" {
    bucket = "akhahskhshs"
    key = "terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = true    #to use locking mechanism 
    dynamodb_table = "kalyan"

  }
}
