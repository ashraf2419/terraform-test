#variable "GIT_TERRAFORM_PASSWORD" {
    #description = "Name of BFF EKS Cluster"
    #type = string
    #default = ""
#}

#variable "GIT_TERRAFORM_USER" {
    #description = "Name of BFF EKS Cluster"
    #type = string
    #default = ""
# 

variable "DYNAMODB_NAME" {
    description = "Name of AWS DYNAMODB"
    type = string
    default = ""
} 

variable "KMS_KEY" {
    description = "Name of AWS S3 KMS_KEY"
    type = string
    default = ""
} 

variable "BUCKET_NAME" {
    description = "Name of BUCKET_NAME"
    type = string
    default = ""
}

variable "ENV" {
    description = "Type of the environment like DEV PROD UAT etc"
    type = string
    default = ""
}
variable "AWS_ACCOUNT_ID" {
    description = "AWS Account ID"
    type = number
    default = 0  
}