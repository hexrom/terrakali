# kali-tf
Terraform automation to deploy Kali Linux penetration testing distro instances in AWS

## Module Inputs

| Name            | Description                                        |  Type  | Default | Required |
| --------------- | -------------------------------------------------- | :----: | :-----: | :------: |
| name            | Name or deployed instance                          | string |  none   |   yes    |
| subnet_id       | Subnet Id where to deploy the instance             | string |  none   |   yes    |
| security_groups | Security groups to be attached to the new instance |  list  |  none   |   yes    |
| tags            | Tags to be added to new instance                   |  map   |  none   |   yes    |
| public_key      | Public key used to access new instance via SSH     | string |  none   |   yes    |

## Example Login to Kali Linux instances

```BASH
ssh -i "~/.ssh/id_rsa" kali@internal_ip_address_of_instance
```
