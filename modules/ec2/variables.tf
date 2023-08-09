variable name {
  type = string
}

variable tags {
  type = map
}

variable subnet_id {
  type = string
}

variable security_groups {
  type = list
}

variable instance_profile {
  type    = string
  default = ""
}

variable public_key {
  type = string
}

variable enabled {
  default = true
}
