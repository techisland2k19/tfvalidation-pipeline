#variable "project_id" {
  #description = "The project id for where the VPC will reside"
  # default= "cp100-225420"
#}

variable "name" {
    description = "The name of the VPC beig created."
    type        = "string"
   default ="hellovpc"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    type        = "string"
    default     = "p-02-08-19-gcp-lab-admin4"
}

variable "auto_create_subnetworks" {
    description = "If set to true, this network will be created in auto subnet mode, and Google will create a subnet for each region automatically. If set to false, a custom subnetted network will be created that can support google_compute_subnetwork resources."
    type        = "string"
    default     = "false"
}

variable "routing_mode" {
    description = "Sets the network-wide routing mode for Cloud Routers to use. Accepted values are GLOBAL or REGIONAL."
    type        = "string"
    default     = "GLOBAL"
}

variable "subnetworks" {
    description = "Define subnetwork detail for VPC"
    type        = "list"
    default     =  [
        {
            subnetname       = "subnetss-1"
            region           = "us-east1"
            cidr             = "192.168.0.0/24"
            #enable_flow_logs = "true"
            #private_ip_google_access = "false"
        },
   
        {
            subnetname       = "subnet-1"
            region  = "us-east4"
            cidr    = "192.168.13.0/24"
        }
]
}


variable "secondary_ranges" {
  type        = "map"
  description = "Secondary ranges that will be used in some of the subnets"
  default =  {

  us-east1 = [
      {
        range_name    = "us-east1-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
 {
        range_name    = "us-east1-secondary-01-02"
        ip_cidr_range = "192.168.65.0/24"
      },
    ]

  us-east4 = [
  {
        range_name    = "us-east4-ssecondary-01"
        ip_cidr_range = "192.168.74.0/24"
      },

   ]
 }
}





variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency. Output from another module can be passed down in order to enforce dependencies"
}



variable fw_name {
  description = "A unique name for the resource, required by GCE"
  default ="ssh"
}


variable protocol {
  description = "The name of the protocol to allow"
default ="tcp"
}

variable ports {
  description = "List of ports and/or port ranges to allow. This can only be specified if the protocol is TCP or UDP"
  type        = "list"
default =["22"]
}

variable source_ranges {
  description = "A list of source CIDR ranges that this firewall applies to. Can't be used for EGRESS"
  type        = "list"
default =["0.0.0.0/0"]
}


/******************************************
	not tested yet

subnets = [
    {
      subnet_name           = "test-network-01-subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name           = "test-network-01-subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "false"
      subnet_flow_logs      = "true"
    },

variable "secondary_ranges" {
  type        = "map"
  description = "Secondary ranges that will be used in some of the subnets"
}

secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = "192.168.64.0/24"
      },
 {
        range_name    = "test-network-01-subnet-01-02"
        ip_cidr_range = "192.168.65.0/24"
      },
    ]

    subnet-02 = []
    test-network-01-subnet-02 = [
{
        range_name    = "test-network-01-subnet-02-01"
        ip_cidr_range = "192.168.74.0/24"
      },
  }



variable "routes" {
  type        = "list"
  description = "List of routes being created in this VPC"
  default     = []
}

routes = [
    {
      name             = "egress-inet"
      description      = "route through IGW to access internet"
      dest_range       = "0.0.0.0/0"
      tags             = "egress-inet"
      next_hop_gateway = "true"
    },
  ]

routes = [
    {
      name              = "egress-inet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_gateway  = "true"
    },
    {
      name              = "app-proxy"
      description       = "route through proxy to reach app"
      destination_range = "10.50.10.0/24"
      tags              = "app-proxy"
      next_hop_ip       = "10.10.40.10"
    },
  ]

variable "shared_vpc_host" {
  type        = "string"
  description = "Makes this project a Shared VPC host if 'true' (default 'false')"
  default     = "false"
}

 *****************************************/

variable "names" {
  description = "Names of the buckets to create in module."
  type        = list(string)
  default = [""]
}
