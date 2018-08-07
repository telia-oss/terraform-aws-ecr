# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

variable "name_prefix" {
  description = "A prefix used for naming resources."
}

variable "max_images_retained" {
  description = "The max number of images to keep in the repository before expiring the oldest"
  default     = 100
}

variable "tags" {
  description = "A map of tags (key-value pairs) passed to resources."
  type        = "map"
  default     = {}
}

variable "trusted_accounts" {
  description = "IDs of other accounts that are trusted to pull and push to this repostitory"
  type        = "list"
  default     = []
}
