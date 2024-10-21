variable "vpc-config" {
  description = "provide the cidr block and vpc name from the user"

  type = object({
    cidr_block = string
    name = string
  })

   validation {
    condition     = can(cidrnetmask(var.vpc-config.cidr_block))
    error_message = "Invalid CIDR Format - ${var.vpc-config.cidr_block}"
  }
}

variable "subnet_config" {
  # sub1={cidr=.. az=..} sub2={} sub3={}
  description = "Get the CIDR and AZ for the subnets"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool,false)
  }))
  validation {
    # sub1={cidr=} sub2={cidr=..}, [true, true, false]
    condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}