resource "aws_kms_key" "uat-federal_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation = "true"
tags = {

Name = "${var.KMS_KEY}-KMS-KEY"
Env = "${var.ENV}"

}

}


resource "aws_kms_alias" "uat-federal-alias" {
  name          = "alias/uat-federal-key"
  target_key_id = aws_kms_key.uat-federal_key.key_id
}

resource "aws_s3_bucket" "uat-federal-terraform" {

bucket = "${var.BUCKET_NAME}"
acl    = "private"

versioning {

enabled = true

}

lifecycle {

prevent_destroy = false

}

server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.uat-federal_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
}

tags = {

Name = "${var.BUCKET_NAME}"
Env = "${var.ENV}"

}

}


resource "aws_s3_bucket_public_access_block" "uat-federal-terraform" {
  bucket = aws_s3_bucket.uat-federal-terraform.id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}

resource "aws_s3_bucket_policy" "uat-federal-terraform" {
  bucket = aws_s3_bucket.uat-federal-terraform.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "SSLDENAY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = "${aws_s3_bucket.uat-federal-terraform.arn}/*",
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}
#If we want to manally create the bucket and apply policies
# {
#     "Version": "2012-10-17",
#     "Id": "SSLDENAY",
#     "Statement": [
#         {
#             "Sid": "IPAllow",
#             "Effect": "Deny",
#             "Principal": "*",
#             "Action": "s3:*",
#             "Resource": "arn:aws:s3:::uat-federal-terraform/*",
#             "Condition": {
#                 "Bool": {
#                     "aws:SecureTransport": "false"
#                 }
#             }
#         }
#     ]
# }

resource "aws_dynamodb_table" "tf-observability-locktable" {

name = "${var.DYNAMODB_NAME}"

hash_key = "LockID"

read_capacity = 1

write_capacity = 1
point_in_time_recovery {
    enabled = true
    }

attribute {

name = "LockID"

type = "S"

}

}
