#resource "aws_dynamodb_table" "tf-observability-locktable" {

#name = "${var.DYNAMODB_NAME}"

#hash_key = "LockID"

#read_capacity = 1

#write_capacity = 1
#point_in_time_recovery {
 #   enabled = true
  #  }

#attribute {

#name = "LockID"

#type = "S"

#}

#}
