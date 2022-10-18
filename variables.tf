##########################################
### ASG Specific Variables
##########################################
variable "name" {
    description = "(Required) Name of the Auto Scaling Group."
    type        = string
}

variable "min_size" {
    description = "(Required) Minimum size of the Auto Scaling Group."
    type        = number
}

variable "max_size" {
    description = "(Required) Maximum size of the Auto Scaling Group."
    type        = number
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in ASG"
  type        = number
  default     = null
}

variable "vpc_zone_identifier" {
    description = "(Required) List of subnet IDs to launch resources in."
    type        = list(string)
}

variable "capacity_rebalance" {
    description = "(Optional) Whether capacity rebalance is enabled."
    type        = bool
    default     = false
}

variable "default_cooldown" {
    description = "(Optional) Amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
    type        = number
    default     = null
}

variable "default_instance_warmup" {
    description = "(Optional) Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics."
    type        = number
    default     = null
}

variable "protect_from_scale_in" {
  description = "(Optional) Whether newly launched instances are automatically protected from termination by Amazon EC2 Auto Scaling when scaling in."
  type        = bool
  default     = false
}

##########################################
### Launch template Specific Variables
########################################## 
variable "launch_template_name" {
    description = "(Optional) The name of the launch template."
    type        = string
    default     = ""
}

variable "launch_template_description" {
    description = "(Optional) Description of the launch template."
    type        = string
    default     = ""
}

variable "instance_type" {
  description = "(Required) The type of the instance."
  type        = string
}

variable "image_id" {
    description = "(Required) The AMI from which to launch the instance."
    type        = string
}

variable "user_data" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "health_check_type" {
  description = "`EC2` or `ELB`. Controls how health checking is done"
  type        = string
  default     = null
}

variable "block_device_mappings" {
  description = <<EOF
List of Volumes to attach to the instance besides the volumes specified by the AMI 
where each entry will be a map of the following properties:

name: The name of the device to mount.
no_device: Suppresses the specified device included in the AMI's block device mapping.
virtual_name: (Optional) The Instance Store Device Name  (e.g., `ephemeral0`)
ebs_delete_on_termination: (Optional, default `false`) Whether the volume should be destroyed on instance termination.
ebs_encrypted: (Optional, default `false`) Enables EBS encryption on the volume
ebs_kms_key_id: (Optional) The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume.
ebs_snapshot_id: The Snapshot ID to mount.
ebs_volume_size: The size of the volume in gigabytes.
ebs_volume_type: (optional, default `gp2`) The volume type
ebs_iops: (Optional) The amount of provisioned IOPS
ebs_throughput: (Optional) The throughput to provision for a gp3 volume in MiB/s (specified as an integer, e.g., 500), with a maximum of 1,000 MiB/s.

1. `ebs_encrypted` must be set to true when `ebs_kms_key_id` is set.
2. `ebs_iops` must be set with a `ebs_volume_type` of "io1/io2".
3. Either one of `ebs_encrypted` as `true` and `ebs_snapshot_id` can be used
EOF
  type        = list(any)
  default     = []
}

variable "cpu_options" {
  description = <<EOF
The CPU options Map for the instance with the following keys:

core_count: (required) The number of CPU cores for the instance.
threads_per_core:  (Optional, default 2) The number of threads per CPU core.
EOF
  type        = map(number)
  default     = {}
}

variable "credit_specifcation" {
    description = "Instance Credit specification"
    type        = map(string)
    default     = {}
    validation {
        condition = (lookup(var.credit_specifcation, "cpu_credits", "") == "") ? true : (var.credit_specifcation.cpu_credits == "standard" ||  var.credit_specifcation.cpu_credits == "unlimited")
        error_message = "CPU Credits can be `standard` or `unlimited`."
    }
}

variable "default_version" {
    description = "Default Version of the launch template."
    type        = string
    default     = null
}

variable "disable_api_stop" {
    description = "(Optional) If true, enables EC2 Instance Stop Protection."
    type        = bool
    default     = false
}

variable "disable_api_termination" {
    description = "(Optional) If true, enables EC2 Instance Termination Protection"
    type        = bool
    default     = false
}

variable "ebs_optimized" {
  description = "(Optional) If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "elastic_gpu_specifications" {
  description = <<EOF
The Elastic GPU Specification Map

gpu_type: The Elastic GPU Type
EOF
  type        = map(string)
  default     = {}
}

##########################################
### Instance Profile Specific Variables
##########################################
variable "create_instance_profile" {
    description = "Flag to decide is an IAM instance profile is created"     
    type        = bool 
    default     = false
}

variable "instance_profile_name" {
    description = "The name of the instance profile"  
    type        = string
    default     = ""   
}

variable "instance_profile_path" {
    description = "(Optional) Path to the instance profile."  
    type        = string
    default = "/" 
}

variable "create_instance_profile_role" {
    description = "(Optional) Flag to decide if new role for Instance Profile is required or to use existing IAM Role"
    type        = bool
    default     = true
}

variable "instance_profile_role_name" {
    description = "(Optional) Name of the IAM role if `create_instance_profile_role` is false"
    type        = string  
    default     = ""
}

variable "instance_profile_policies" {
  description = "(Optional) List of Policies (to be provisioned) to be attached to Instance profile"
  default = []
}

##########################################
### Tags
##########################################
variable "default_tags" {
  description = "(Optional) A map of tags to assign to all the resource."
  type        = map(any)
  default     = {}
}

variable "instance_profile_tags" {
  description = "(Optional) A map of tags to assign to Instance Profile and role."
  type        = map(any)
  default     = {}
}
