terraform {
  backend "s3" {
    bucket         = "aset-terraform-state-bucket"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
