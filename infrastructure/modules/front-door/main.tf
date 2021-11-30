locals {
  waf-policy-name = "${var.company_name}${var.short_region}${var.env}${var.project_name}wafpolicy"
  afd-name        = "${var.company_name}-${var.short_region}-${var.env}-${var.project_name}-afd"
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

# Create front door
resource "azurerm_frontdoor_firewall_policy" "policy" {
  name                              = local.waf-policy-name
  resource_group_name               = var.resource_group_name
  enabled                           = true
  mode                              = "Prevention"
  custom_block_response_status_code = 403
  /*
  custom_block_response_body takes in is a base 64 encoded string, hence this is the base 64 encoded string for 
  "blocked by frontdoor"
  */
  custom_block_response_body = "YmxvY2tlZCBieSBmcm9udGRvb3I="

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
  }
}

resource "azurerm_frontdoor" "frontdoor" {
  name                                         = local.afd-name
  resource_group_name                          = var.resource_group_name
  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "HttpsRoutingRule"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = [local.afd-name]
    forwarding_configuration {
      forwarding_protocol                   = "HttpsOnly"
      backend_pool_name                     = "apiBackend"
      cache_enabled                         = true
      cache_query_parameter_strip_directive = "StripNone"
      cache_use_dynamic_compression         = true
    }

  }

  backend_pool_load_balancing {
    name = "LoadBalancingSettings"

  }

  backend_pool_health_probe {
    name     = "DemoHealthProbeSetting"
    protocol = "Https"
    path     = "/api/Health"
    interval_in_seconds = 250
  }

  backend_pool {
    name = "apiBackend"
    backend {
      host_header = "${var.function_app_name}.azurewebsites.net"
      address     = "${var.function_app_name}.azurewebsites.net"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "LoadBalancingSettings"
    health_probe_name   = "DemoHealthProbeSetting"
  }

  frontend_endpoint {
    name                                    = local.afd-name
    host_name                               = "${local.afd-name}.azurefd.net"
    session_affinity_enabled                = false
    session_affinity_ttl_seconds            = 0
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.policy.id
  }
}