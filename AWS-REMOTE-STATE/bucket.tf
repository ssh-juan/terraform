resource "aws_s3_bucket" "first-bucket" {
  bucket = "jbs-remote-state"

  versioning {
    enabled = true
  }
}