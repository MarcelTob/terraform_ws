
variable "test" {
  type    = string
  default = "Hello World!"
}

variable "message" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
  validation {
    condition     = contains(["prod", "qa", "dev"], var.environment)
    error_message = format("Value %s must be one of: %v", var.environment, "qa,prod,dev")
  }
}


variable "envs" {
  type    = list(string)
  default = ["prod", "dev", "qa"]
}

# tuple can contain distinct types
variable "tuple" {
  type    = tuple([string, bool, number])
  default = ["prod", false, 4]
}

# set contains unique values
variable "set" {
  type    = set(string)
  default = ["prod", "prod", "qa"]
}

variable "map" {
  type = map(string)
  default = {
    "prod" = "Prod"
  }
}

variable "vnets" {
  type = list(object({
    name          = string
    address_space = list(string)
    subnets       = map(string)
  }))
  default = [
    {
      name          = "ws-mato-dev-vnet-1"
      address_space = ["10.1.0.0/16"]
      subnets = {
        "private_endpoints" = "10.1.0.0/24"
        "load_balancer"     = "10.1.1.0/24"
      }
    },
    {
      name          = "ws-mato-dev-vnet-2"
      address_space = ["10.0.0.0/16"]
      subnets = {
        "vm"                = "10.0.0.0/24"
        "private_endpoints" = "10.0.1.0/24"
      }
  }]
}
