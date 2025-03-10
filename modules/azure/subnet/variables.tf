variable "resource_group_name" {
  description = "Specifies the name of the resource group the Virtual Network is located in."
  type        = string
}

variable "prefix" {
  description = "The prefix name that will be used in the subnet naming convention."
  type        = string
}

variable "name" {
  description = "The base name that will be used in the subnet naming convention."
  type        = string
}

variable "environment" {
  description = "Specifies the environment the subnet belongs to."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "tst", "acc", "stg", "prd"], var.environment)
    error_message = "Invalid value for environment. Must be one of: `dev`, `tst`, `acc`, `stg`, `prd`."
  }
}

variable "virtual_network_name" {
  description = "Specifies the name of the Virtual Network this Subnet is located within."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)

  validation {
    condition     = length(var.address_prefixes) == 1
    error_message = "Currently only a single address prefix can be set for a subnet."
  }
}

variable "delegations" {
  description = "List of delegation blocks for services to delegate to the subnet."
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string))
    })
  }))
  default = []
  validation {
    condition = alltrue([
      for d in var.delegations : contains([
        "GitHub.Network/networkSettings", "Informatica.DataManagement/organizations",
        "Microsoft.ApiManagement/service", "Microsoft.Apollo/npu",
        "Microsoft.App/environments", "Microsoft.App/testClients",
        "Microsoft.AVS/PrivateClouds", "Microsoft.AzureCosmosDB/clusters",
        "Microsoft.BareMetal/AzureHostedService", "Microsoft.BareMetal/AzureHPC",
        "Microsoft.BareMetal/AzurePaymentHSM", "Microsoft.BareMetal/AzureVMware",
        "Microsoft.BareMetal/CrayServers", "Microsoft.BareMetal/MonitoringServers",
        "Microsoft.Batch/batchAccounts", "Microsoft.CloudTest/hostedpools",
        "Microsoft.CloudTest/images", "Microsoft.CloudTest/pools",
        "Microsoft.Codespaces/plans", "Microsoft.ContainerInstance/containerGroups",
        "Microsoft.ContainerService/managedClusters", "Microsoft.ContainerService/TestClients",
        "Microsoft.Databricks/workspaces", "Microsoft.DBforMySQL/flexibleServers",
        "Microsoft.DBforMySQL/servers", "Microsoft.DBforMySQL/serversv2",
        "Microsoft.DBforPostgreSQL/flexibleServers", "Microsoft.DBforPostgreSQL/serversv2",
        "Microsoft.DBforPostgreSQL/singleServers", "Microsoft.DelegatedNetwork/controller",
        "Microsoft.DevCenter/networkConnection", "Microsoft.DevOpsInfrastructure/pools",
        "Microsoft.DocumentDB/cassandraClusters", "Microsoft.Fidalgo/networkSettings",
        "Microsoft.HardwareSecurityModules/dedicatedHSMs", "Microsoft.Kusto/clusters",
        "Microsoft.LabServices/labplans", "Microsoft.Logic/integrationServiceEnvironments",
        "Microsoft.MachineLearningServices/workspaces", "Microsoft.Netapp/volumes",
        "Microsoft.Network/dnsResolvers", "Microsoft.Network/managedResolvers",
        "Microsoft.Network/fpgaNetworkInterfaces", "Microsoft.Network/networkWatchers.",
        "Microsoft.Network/virtualNetworkGateways", "Microsoft.Orbital/orbitalGateways",
        "Microsoft.PowerPlatform/enterprisePolicies", "Microsoft.PowerPlatform/vnetaccesslinks",
        "Microsoft.ServiceFabricMesh/networks", "Microsoft.ServiceNetworking/trafficControllers",
        "Microsoft.Singularity/accounts/networks", "Microsoft.Singularity/accounts/npu",
        "Microsoft.Sql/managedInstances", "Microsoft.Sql/managedInstancesOnebox",
        "Microsoft.Sql/managedInstancesStage", "Microsoft.Sql/managedInstancesTest",
        "Microsoft.Sql/servers", "Microsoft.StoragePool/diskPools",
        "Microsoft.StreamAnalytics/streamingJobs", "Microsoft.Synapse/workspaces",
        "Microsoft.Web/hostingEnvironments", "Microsoft.Web/serverFarms",
        "NGINX.NGINXPLUS/nginxDeployments", "PaloAltoNetworks.Cloudngfw/firewalls",
        "Qumulo.Storage/fileSystems", "Oracle.Database/networkAttachments"
      ], d.service_delegation.name)
    ])
    error_message = "Service delegation name must be one of the supported services."
  }
}

variable "default_outbound_access_enabled" {
  description = "Enable default outbound access to the internet for the subnet. Defaults to `true`."
  type        = bool
  default     = true
}

variable "private_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private endpoint on the subnet. Defaults to `Disabled`."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
    error_message = "Invalid value for private_endpoint_network_policies. Must be one of: `Disabled`, `Enabled`, `NetworkSecurityGroupEnabled`, `RouteTableEnabled`."
  }
}

variable "private_link_service_network_policies_enabled" {
  description = "Enable or Disable network policies for the private link service on the subnet. Defaults to `true`."
  type        = bool
  default     = true
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for endpoint in var.service_endpoints : contains([
        "Microsoft.AzureActiveDirectory",
        "Microsoft.AzureCosmosDB",
        "Microsoft.ContainerRegistry",
        "Microsoft.EventHub",
        "Microsoft.KeyVault",
        "Microsoft.ServiceBus",
        "Microsoft.Sql",
        "Microsoft.Storage",
        "Microsoft.Storage.Global",
        "Microsoft.Web"
      ], endpoint)
    ])
    error_message = "Service endpoints must be from the allowed list of Microsoft service endpoints."
  }
}

variable "service_endpoint_policy_ids" {
  description = "The list of ID's of Service Endpoint Policies to associate with the subnet."
  type        = list(string)
  default     = []
}
