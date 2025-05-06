terraform {
  backend "s3" {
    bucket         = "state-bucket-586794467501"
    key            = "state-file/tfstate"
    region         = "us-east-1"
    encrypt        = true
    profile        = "nayra"
    use_lockfile = true
  }
}

