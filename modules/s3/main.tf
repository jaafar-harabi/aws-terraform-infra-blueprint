variable "name" { type = string }

resource "random_id" "rand" { byte_length = 4 }

resource "aws_s3_bucket" "app" {
  bucket = "${var.name}-assets-${random_id.rand.hex}"
  tags   = { Name = "${var.name}-assets" }
}

output "bucket" { value = aws_s3_bucket.app.bucket }
