variable "resource_group_name" {
  description = "The name of the Resource Group where the Storage Account should be created."
  type        = string
}

variable "prefix" {
  description = "The prefix name that will be used in the storage account naming convention."
  type        = string
}

variable "name" {
  description = "The base name that will be used in the storage account naming convention."
  type        = string
}

variable "environment" {
  description = "Specifies the environment the storage account belongs to."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "location" {
  description = "Specifies the supported Azure location where the storage account exists."
  type        = string
  default     = "westeurope"
}

variable "account_kind" {
  description = "Defines the Kind of storage account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Defaults to `StorageV2`."
  type        = string
  default     = "StorageV2"

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Invalid value for account_kind. Must be one of: `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage`, `StorageV2`"
  }
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. Defaults to `Standard`."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Invalid value for account_tier. Must be one of: `Standard`, `Premium`."
  }
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. Defaults to `LRS`."
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
    error_message = "Invalid value for account_replication_type. Must be one of: `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS`, `RAGZRS`."
  }
}

variable "cross_tenant_replication_enabled" {
  description = "Whether cross Tenant replication should be enabled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "access_tier" {
  description = "Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot`, `Cool`, `Cold` and `Premium`. Defaults to `Hot`."
  type        = string
  default     = "Hot"

  validation {
    condition     = contains(["Hot", "Cool", "Cold", "Premium"], var.access_tier)
    error_message = "Invalid value for access_tier. Must be one of: `Hot`, `Cool`, `Cold`, `Premium`."
  }
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist."
  type        = string
  default     = null
}

variable "https_traffic_only_enabled" {
  description = "Whether to force-enable HTTPS. Defaults to `true`."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Valid options are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2`."
  type        = string
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Invalid value for min_tls_version. Must be one of: `TLS1_0`, `TLS1_1`, `TLS1_2`."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Whether nested items within this Account can opt into being public. Defaults to `true`."
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "Whether the storage account permits requests to be authorised with the account access key via Shared Key. If `false`, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). Defaults to `true`."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled. Defaults to `true`."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "Whether to default to Azure Active Directory authorisation in the Azure portal when accessing the Storage Account. Defaults to `false`."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Whether Hierarchical Namespace is enabled."
  type        = bool
  default     = null
}

variable "nfsv3_enabled" {
  description = "Whether NFSv3 protocol is enabled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "custom_domain" {
  description = "The custom domain configuration for the storage account."
  type = object({
    name          = string
    use_subdomain = optional(bool, null)
  })
  default = null
}

variable "customer_managed_key" {
  description = "The configuration for customer-managed keys for server-side encryption. The block requires a `user_assigned_identity_id` and exactly one of `key_vault_key_id` or `managed_hsm_key_id`."
  type = object({
    key_vault_key_id          = optional(string)
    managed_hsm_key_id        = optional(string)
    user_assigned_identity_id = string
  })
  default = null


  validation {
    condition = var.customer_managed_key == null ? true : (
      (var.customer_managed_key.key_vault_key_id != null && var.customer_managed_key.managed_hsm_key_id == null) ||
      (var.customer_managed_key.key_vault_key_id == null && var.customer_managed_key.managed_hsm_key_id != null)
    )
    error_message = "Exactly one of `key_vault_key_id` or `managed_hsm_key_id` must be specified in `customer_managed_key`."
  }
}

variable "identity" {
  description = "The Managed Service Identity configuration for the Storage Account. Valid identity type options are `SystemAssigned`, `UserAssigned`, or `SystemAssigned, UserAssigned`. When including `UserAssigned`, `identity_ids` must be provided."
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.identity == null ? true : contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type)
    error_message = "Invalid value for identity.type. Must be one of: `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`."
  }

  validation {
    condition = var.identity == null ? true : (
      var.identity.type == "SystemAssigned" ? length(coalesce(var.identity.identity_ids, [])) == 0 : true
    )
    error_message = "When identity type is `SystemAssigned`, `identity_ids` should not be provided."
  }

  validation {
    condition = var.identity == null ? true : (
      contains(["UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type) ? length(coalesce(var.identity.identity_ids, [])) > 0 : true
    )
    error_message = "When identity type includes `UserAssigned`, at least one `identity_ids` must be provided."
  }
}

variable "blob_properties" {
  description = "The configuration settings for Azure Storage blob properties including CORS rules, retention policies, versioning, change feed, and container deletion policies."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), [])
    delete_retention_policy = optional(object({
      days    = optional(number)
      enabled = bool
    }))
    restore_policy = optional(object({
      days    = optional(number)
      enabled = bool
    }))
    versioning_enabled            = optional(bool, false)
    change_feed_enabled           = optional(bool, false)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool, false)
    container_delete_retention_policy = optional(object({
      days    = optional(number)
      enabled = bool
    }))
  })
  default = null

  validation {
    condition = var.blob_properties == null ? true : (
      var.blob_properties.restore_policy == null ? true : (
        var.blob_properties.delete_retention_policy != null &&
        var.blob_properties.delete_retention_policy.enabled == true &&
        var.blob_properties.versioning_enabled == true &&
        var.blob_properties.change_feed_enabled == true
      )
    )
    error_message = "When `restore_policy` is specified, `delete_retention_policy` must be enabled and both `versioning_enabled` and `change_feed_enabled` must be set to `true`."
  }

  validation {
    condition = var.blob_properties == null ? true : (
      var.blob_properties.change_feed_retention_in_days == null ? true : (
        var.blob_properties.change_feed_retention_in_days >= 1 &&
        var.blob_properties.change_feed_retention_in_days <= 146000
      )
    )
    error_message = "If specified, `change_feed_retention_in_days` must be between 1 and 146000 days."
  }
}

variable "queue_properties" {
  description = "The configuration settings for Azure Storage queue properties including CORS rules, logging configuration, and metrics collection. Queue properties are only available for storage accounts of kind `StorageV2`, `Storage`, or `BlobStorage`."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), [])
    logging = optional(object({
      delete                = bool
      read                  = bool
      write                 = bool
      version               = string
      retention_policy_days = optional(number)
    }))
    minute_metrics = optional(object({
      enabled               = bool
      version               = string
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
    }))
    hour_metrics = optional(object({
      enabled               = bool
      version               = string
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
    }))
  })
  default = null

  validation {
    condition = var.queue_properties == null ? true : (
      var.queue_properties.logging == null ? true : (
        var.queue_properties.logging.retention_policy_days == null ? true : (
          var.queue_properties.logging.retention_policy_days >= 1 &&
          var.queue_properties.logging.retention_policy_days <= 365
        )
      )
    )
    error_message = "If specified, queue `logging.retention_policy_days` must be between 1 and 365 days."
  }

  validation {
    condition = var.queue_properties == null ? true : (
      var.queue_properties.minute_metrics == null ? true : (
        var.queue_properties.minute_metrics.retention_policy_days == null ? true : (
          var.queue_properties.minute_metrics.retention_policy_days >= 1 &&
          var.queue_properties.minute_metrics.retention_policy_days <= 365
        )
      )
    )
    error_message = "If specified, queue `minute_metrics.retention_policy_days` must be between 1 and 365 days."
  }

  validation {
    condition = var.queue_properties == null ? true : (
      var.queue_properties.hour_metrics == null ? true : (
        var.queue_properties.hour_metrics.retention_policy_days == null ? true : (
          var.queue_properties.hour_metrics.retention_policy_days >= 1 &&
          var.queue_properties.hour_metrics.retention_policy_days <= 365
        )
      )
    )
    error_message = "If specified, queue `hour_metrics.retention_policy_days` must be between 1 and 365 days."
  }
}

variable "static_website" {
  description = "The configuration for hosting static website content in the storage account. Only applicable for `StorageV2` and `BlockBlobStorage` account kinds. Both `index_document` and `error_404_document` are optional, but typically at least `index_document` should be set for proper functionality."
  type = object({
    index_document     = optional(string, null)
    error_404_document = optional(string, null)
  })
  default = null

  validation {
    condition = var.static_website == null ? true : (
      var.static_website.index_document != null || var.static_website.error_404_document != null
    )
    error_message = "At least one of `index_document` or `error_404_document` must be specified when using `static_website`."
  }
}

variable "share_properties" {
  description = "The configuration for Azure Files share properties including CORS rules, retention policies, and SMB settings. These properties control how file shares behave in the storage account."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })), [])
    retention_policy = optional(object({
      days = optional(number)
    }))
    smb = optional(object({
      versions                        = optional(list(string))
      authentication_types            = optional(list(string))
      kerberos_ticket_encryption_type = optional(list(string))
      channel_encryption_type         = optional(list(string))
      multichannel_enabled            = optional(bool)
    }))
  })
  default = null


  validation {
    condition = var.share_properties == null ? true : (
      var.share_properties.retention_policy == null ? true : (
        var.share_properties.retention_policy.days == null ? true : (
          var.share_properties.retention_policy.days >= 1 &&
          var.share_properties.retention_policy.days <= 365
        )
      )
    )
    error_message = "If specified, `share.retention_policy` days must be between 1 and 365 days."
  }

  validation {
    condition = var.share_properties == null ? true : (
      var.share_properties.smb == null ? true : (
        var.share_properties.smb.versions == null ? true : (
          length([
            for v in var.share_properties.smb.versions : v
            if contains(["SMB2.1", "SMB3.0", "SMB3.1.1"], v)
          ]) == length(var.share_properties.smb.versions)
        )
      )
    )
    error_message = "Invalid value for smb.versions. Must be one or more of: `SMB2.1`, `SMB3.0`, `SMB3.1.1`."
  }

  validation {
    condition = var.share_properties == null ? true : (
      var.share_properties.smb == null ? true : (
        var.share_properties.smb.authentication_types == null ? true : (
          length([
            for v in var.share_properties.smb.authentication_types : v
            if contains(["NTLMv2", "Kerberos"], v)
          ]) == length(var.share_properties.smb.authentication_types)
        )
      )
    )
    error_message = "Invalid value for smb.authentication_types. Must be one or more of: `NTLMv2`, `Kerberos`."
  }

  validation {
    condition = var.share_properties == null ? true : (
      var.share_properties.smb == null ? true : (
        var.share_properties.smb.kerberos_ticket_encryption_type == null ? true : (
          length([
            for v in var.share_properties.smb.kerberos_ticket_encryption_type : v
            if contains(["RC4-HMAC", "AES-256"], v)
          ]) == length(var.share_properties.smb.kerberos_ticket_encryption_type)
        )
      )
    )
    error_message = "Invalid value for smb.kerberos_ticket_encryption_type. Must be one or more of: `RC4-HMAC`, `AES-256`."
  }

  validation {
    condition = var.share_properties == null ? true : (
      var.share_properties.smb == null ? true : (
        var.share_properties.smb.channel_encryption_type == null ? true : (
          length([
            for v in var.share_properties.smb.channel_encryption_type : v
            if contains(["AES-128-CCM", "AES-128-GCM", "AES-256-GCM"], v)
          ]) == length(var.share_properties.smb.channel_encryption_type)
        )
      )
    )
    error_message = "Invalid value for smb.channel_encryption_type. Must be one or more of: `AES-128-CCM`, `AES-128-GCM`, `AES-256-GCM`."
  }
}

variable "network_rules" {
  description = "Network rules that control access to the storage account. Includes default action (allow/deny), service bypass options, IP rules, virtual network rules, and private link access configurations."
  type = object({
    default_action             = string
    bypass                     = optional(list(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })), [])
  })
  default = null

  validation {
    condition     = var.network_rules == null ? true : contains(["Allow", "Deny"], var.network_rules.default_action)
    error_message = "Invalid value for network_rules.default_action. Must be one of: `Allow`, `Deny`."
  }

  validation {
    condition = var.network_rules == null ? true : (
      var.network_rules.bypass == null ? true : (
        length([
          for b in var.network_rules.bypass : b
          if !contains(["Logging", "Metrics", "AzureServices", "None"], b)
        ]) == 0
      )
    )
    error_message = "Invalid value for network_rules.bypass. Must be one or more of: `Logging`, `Metrics`, `AzureServices`, `None`."
  }

  validation {
    condition = var.network_rules == null ? true : (
      var.network_rules.ip_rules == null ? true : (
        length([
          for rule in var.network_rules.ip_rules : rule
          if(
            can(cidrnetmask(rule)) ? (
              cidrnetmask(rule) != "255.255.255.254" &&
              cidrnetmask(rule) != "255.255.255.255" &&
              !startswith(rule, "10.") &&
              !startswith(rule, "172.16.") && !startswith(rule, "172.17.") && !startswith(rule, "172.18.") &&
              !startswith(rule, "172.19.") && !startswith(rule, "172.20.") && !startswith(rule, "172.21.") &&
              !startswith(rule, "172.22.") && !startswith(rule, "172.23.") && !startswith(rule, "172.24.") &&
              !startswith(rule, "172.25.") && !startswith(rule, "172.26.") && !startswith(rule, "172.27.") &&
              !startswith(rule, "172.28.") && !startswith(rule, "172.29.") && !startswith(rule, "172.30.") &&
              !startswith(rule, "172.31.") &&
              !startswith(rule, "192.168.")
              ) : (
              can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", rule))
            )
          )
        ]) == length(var.network_rules.ip_rules)
      )
    )
    error_message = "IP rules must be valid IPv4 addresses or CIDR ranges, excluding `/31` CIDRs, `/32` CIDRs, and private IP ranges (`RFC 1918`)."
  }
}

variable "large_file_share_enabled" {
  description = "Whether large file shares are enabled. Defaults. to `false`."
  type        = bool
  default     = false
}

variable "local_user_enabled" {
  description = "Whether local user is enabled. Defaults to `true`."
  type        = bool
  default     = true
}

variable "azure_files_authentication" {
  description = "The configuration for Azure Files authentication options, including directory service type, Active Directory integration, and default share permissions. Used to enable identity-based authentication for Azure Files."
  type = object({
    directory_type                 = string
    default_share_level_permission = optional(string, null)
    active_directory = optional(object({
      domain_name         = string
      domain_guid         = string
      domain_sid          = string
      storage_sid         = string
      forest_name         = optional(string, null)
      netbios_domain_name = optional(string, null)
    }))
  })
  default = null

  validation {
    condition     = var.azure_files_authentication == null ? true : contains(["AADDS", "AD", "AADKERB"], var.azure_files_authentication.directory_type)
    error_message = "Invalid value for azure_files_authentication.directory_type. Must be one of: `AADDS`, `AD`, `AADKERB`."
  }

  validation {
    condition = var.azure_files_authentication == null ? true : (
      var.azure_files_authentication.default_share_level_permission == null ? true :
      contains(["StorageFileDataSmbShareReader", "StorageFileDataSmbShareContributor", "StorageFileDataSmbShareElevatedContributor", "None"],
      var.azure_files_authentication.default_share_level_permission)
    )
    error_message = "Invalid value for azure_files_authentication.default_share_level_permission. Must be one of: `StorageFileDataSmbShareReader`, `StorageFileDataSmbShareContributor`, `StorageFileDataSmbShareElevatedContributor`, `None`."
  }

  validation {
    condition = var.azure_files_authentication == null ? true : (
      var.azure_files_authentication.directory_type != "AD" ? true :
      var.azure_files_authentication.active_directory != null
    )
    error_message = "The active_directory block is required when directory_type is `AD`."
  }
}

variable "routing" {
  description = "The storage account routing configuration to define how the storage account will handle network routing of data."
  type = object({
    publish_internet_endpoints  = optional(bool, false)
    publish_microsoft_endpoints = optional(bool, false)
    choice                      = optional(string, "MicrosoftRouting")
  })
  default = null

  validation {
    condition     = var.routing == null ? true : contains(["MicrosoftRouting", "InternetRouting"], var.routing.choice)
    error_message = "Invalid value for routing.choice. Must be one of: `MicrosoftRouting`, `InternetRouting`."
  }
}

variable "queue_encryption_key_type" {
  description = "The encryption type of the queue service. Valid options are `Service` and `Account`."
  type        = string
  default     = "Service"

  validation {
    condition     = contains(["Service", "Account"], var.queue_encryption_key_type)
    error_message = "Invalid value for queue_encryption_key_type. Must be one of: `Service`, `Account`."
  }
}

variable "table_encryption_key_type" {
  description = "The encryption type of the table service. Valid options are `Service` and `Account`."
  type        = string
  default     = "Service"

  validation {
    condition     = contains(["Service", "Account"], var.table_encryption_key_type)
    error_message = "Invalid value for table_encryption_key_type. Must be one of: `Service`, `Account`."
  }
}

variable "infrastructure_encryption_enabled" {
  description = "Whether infrastructure encryption is enabled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "immutability_policy" {
  description = "The default account-level immutability policy which is inherited and applied to objects that do not possess an explicit immutability policy at the object level."
  type = object({
    allow_protected_append_writes = string
    state                         = optional(string, null)
    period_since_creation_in_days = number
  })
  default = null

  validation {
    condition = var.immutability_policy == null ? true : (
      contains(["true", "false"], lower(var.immutability_policy.allow_protected_append_writes)) &&
      (var.immutability_policy.state == null || contains(["Locked", "Unlocked", "Disabled"], var.immutability_policy.state)) &&
      var.immutability_policy.period_since_creation_in_days > 0
    )
    error_message = "For immutability_policy: allow_protected_append_writes must be `true` or `false`, state must be 'Locked', 'Unlocked', 'Disabled' or null, and period_since_creation_in_days must be greater than 0."
  }
}

variable "sas_policy" {
  description = "The Storage Account's SAS policy configuration. This defines how SAS tokens behave including their expiration period and action taken upon expiration."
  type = object({
    expiration_period = string
    expiration_action = optional(string, "Log")
  })
  default = null

  validation {
    condition = var.sas_policy == null ? true : (
      length(regexall("^[0-9]+\\.[0-9][0-9]:[0-9][0-9]:[0-9][0-9]$", var.sas_policy.expiration_period)) > 0 &&
      var.sas_policy.expiration_action == "Log"
    )
    error_message = "Invalid format for expiration_period must be in the format of 'DD.HH:MM:SS' (e.g., '30.00:00:00' for 30 days) and expiration_action must be `Log`."
  }
}

variable "allowed_copy_scope" {
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Valid options are `AAD` and `PrivateLink`. Defaults to `null`."
  type        = string
  default     = null

  validation {
    condition     = contains(["AAD", "PrivateLink"], var.allowed_copy_scope)
    error_message = "Invalid value for allowed_copy_scope. Must be one of: `AAD`. `PrivateLink`."
  }
}

variable "sftp_enabled" {
  description = "Whether SFTP is enabled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "dns_endpoint_type" {
  description = "Specifies which DNS endpoint type to use. Valid options are `Standard` and `AzureDnsZone`. Defaults to `Standard`."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "AzureDnsZone"], var.dns_endpoint_type)
    error_message = "Invalid value for dns_endpoint_type. Must be one of: `Standard`, `AzureDnsZone`."
  }
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Storage Account."
  type        = map(string)
  default     = {}
}
