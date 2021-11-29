variable "company_name" {
  type        = string
  description = "Short company name used as resource naming prefix."
  default     = "AA"
}

variable "env" {
  type        = string
  description = "Environment into which this app is deployed into."
  validation {
    condition     = contains(["dev", "test", "perf", "staging", "prod"], var.env)
    error_message = "Env variable must contain one of dev,test,perf,staging,prod."
  }
}

variable "short_region" {
  type        = string
  description = "Short azure region name - eun,euw etc."
  validation {
    condition = (
      length(var.short_region) == 3 &&
      contains(["eun", "euw"], var.short_region)
    )
    error_message = "Variable must of exactly 3 chars long - eun, euw etc."
  }
}

variable "project_name" {
  type        = string
  default     = "availableapi"
  description = "Name of the project/platform that this resource is intended for."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group the resource will be part of."
}

variable "kv-key-permissions-full" {
  type        = list(string)
  description = "List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
  default = ["backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge",
  "recover", "restore", "sign", "unwrapKey", "update", "verify", "wrapKey"]
}

variable "kv-secret-permissions-full" {
  type        = list(string)
  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
  default     = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
}

variable "kv-certificate-permissions-full" {
  type        = list(string)
  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
  default = ["create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers",
  "managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore"]
}

variable "kv-storage-permissions-full" {
  type        = list(string)
  description = "List of full storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
  default = ["backup", "delete", "deletesas", "get", "getsas", "list", "listsas",
  "purge", "recover", "regeneratekey", "restore", "set", "setsas", "update"]
}

variable "policies" {
  type = map(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = list(string)
  }))
  description = "Define a Azure Key Vault access policy"
  default     = {}
}

variable "secrets" {
  type = map(object({
    value = string
  }))
  description = "Define Azure Key Vault secrets"
  default     = {}
}