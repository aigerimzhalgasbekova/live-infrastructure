variable "deletion_window_in_days" {
  type        = number
  default     = 7
  description = "The waiting period for key deletion."
}

variable "enable_key_rotation" {
  type        = bool
  default     = false
  description = "Whether to enable key rotation."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to the KMS key."
}

variable "alias_name" {
  type        = string
  description = "The alias name for the KMS key."
}

variable "aws_region" {
  type        = string
  description = "AWS region where resources are created"
}
