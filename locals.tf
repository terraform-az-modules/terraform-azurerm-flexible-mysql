##----------------------------------------------------------------------------- 
## Locals
##-----------------------------------------------------------------------------
locals {
  name = var.custom_name != null ? var.custom_name : module.labels.id
}

locals {
  flattened_rules = {
    for rule_name, ip_ranges in var.firewall_rules :
    rule_name => [
      for idx, ip_range in ip_ranges :
      {
        name     = "${rule_name}-${idx + 1}"
        start_ip = ip_range.start_ip
        end_ip   = ip_range.end_ip
      }
    ]
  }
  all_firewall_rules = flatten([for r in local.flattened_rules : r])
}


