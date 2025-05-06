provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "state-bucket-586794467501" 

  tags = {
    Name        = "Terraform State Bucket"
  }
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
