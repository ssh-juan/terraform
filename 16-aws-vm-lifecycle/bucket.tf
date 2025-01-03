resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-bucket-juan-borges-lifecycle-v1"

  lifecycle {
    #prevent_destroy = true
    create_before_destroy = true
    ignore_changes = [ 
      tags
     ]
  }

  tags = {
    test = "vscode"
  }
}