variable "DB_NAME" {
  description = "The name of the database"
  type        = string
}

variable "DB_USERNAME" {
    description = "The username for the database"
    type        = string
}

variable "DB_PASSWORD" {
    description = "The password for the database"
    type        = string
    sensitive   = true
}

variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS access key"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS secret access"
  type        = string
  sensitive   = true
}

variable "AWS_SESSION_TOKEN" {
  description = "The AWS session token"
  type        = string
  sensitive   = true
}

variable "AWS_REGION" {
  description = "The AWS region"
  default     = "us-east-1"
  type        = string
}

variable "labRole" {
  default = "arn:aws:iam::083261780098:role/LabRole"
}

variable "principalArn" {
  default = "arn:aws:iam::083261780098:role/voclabs"
}
