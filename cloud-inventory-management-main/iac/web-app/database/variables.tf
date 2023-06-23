variable "db_name" {
  description = "Name of DB"
  type        = string
  default     = "inventory"
}

variable "db_user" {
  description = "Username for DB"
  type        = string
  default     = "user"
}

variable "db_pass" {
  description = "Password for DB"
  type        = string
  sensitive   = true
  default     = "pass"
}
