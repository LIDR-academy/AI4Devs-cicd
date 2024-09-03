resource "aws_s3_bucket" "code_bucket" {
  bucket = "lti-project-code-bucket-${random_string.bucket_suffix.result}"
}

resource "aws_s3_bucket_acl" "code_bucket_acl" {
  bucket = aws_s3_bucket.code_bucket.bucket
  acl    = "private"
}

resource "null_resource" "generate_zip" {
  provisioner "local-exec" {
    command = "sh ../generar-zip.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "aws_s3_object" "backend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "backend.zip"
  source = "../backend.zip"
  depends_on = [null_resource.generate_zip]
}

resource "aws_s3_object" "frontend_zip" {
  bucket = aws_s3_bucket.code_bucket.bucket
  key    = "frontend.zip"
  source = "../frontend.zip"
  depends_on = [null_resource.generate_zip]
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}
