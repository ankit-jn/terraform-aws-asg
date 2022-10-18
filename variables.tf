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

variable "capacity_rebalance" {
    description = "(Optional) Whether capacity rebalance is enabled."
    type        = bool
    default     = false
}

variable "vpc_zone_identifier" {
    description = "(Required) List of subnet IDs to launch resources in."
    type        = list(string)
}

variable "placement_group" {
  description = "The name of the placement group into which instances will be launched"
  type        = string
  default     = null
}

variable "service_linked_role_arn" {
  description = "ARN of the service-linked IAM role that the ASG will use to invoke other AWS services"
  type        = string
  default     = null
}

variable "suspended_processes" {
  description = <<EOF
(Optional) List of processes to suspend for ASG. 
The allowed values are as follows:
  `Launch`, 
  `Terminate`, 
  `HealthCheck`, 
  `ReplaceUnhealthy`, 
  `AZRebalance`, 
  `AlarmNotification`, 
  `ScheduledActions`, 
  `AddToLoadBalancer`, 
  `InstanceRefresh`.
EOF
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = <<EOF
(Optional) List of policies to decide how the instances in ASG should be terminated. 
The allowed values are as follows: 
  `OldestInstance`, 
  `NewestInstance`, 
  `OldestLaunchConfiguration`, 
  `ClosestToNextInstanceHour`, 
  `OldestLaunchTemplate`, 
  `AllocationStrategy`, 
  `Default`
EOF
  type        = list(string)
  default     = []
}

variable "force_delete" {
  description = "(Optional) Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate."
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

variable "max_instance_lifetime" {
  description = <<EOF
The maximum amount of time, in seconds, that an instance can be in service.
Possible values: Either `0` or between `86400` and `31536000`
EOF
  type        = number
  default     = null
}

variable "target_group_arns" {
  description = "Set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing"
  type        = list(string)
  default     = []
}

variable "min_elb_capacity" {
  description = <<EOF
Setting this causes Terraform to wait for this number of instances to show up healthy 
in the ELB only on creation. Updates will not wait on ELB instance number changes
EOF
  type        = number
  default     = null
}

variable "wait_for_elb_capacity" {
  description = <<EOF
Setting this will cause Terraform to wait for exactly this number of healthy instances 
in all attached load balancers on both create and update operations. 
Takes precedence over `min_elb_capacity` behavior.
EOF
  type        = number
  default     = null
}

variable "wait_for_capacity_timeout" {
  description = <<EOF
A maximum duration that Terraform should wait for ASG instances to be healthy before timing out.
Setting this to '0' causes Terraform to skip all Capacity Waiting behavior.
EOF
  type        = string
  default     = null
}

variable "health_check_type" {
  description = "Controls how health checking is done. Possible Values: `EC2` or `ELB`."
  type        = string
  default     = null
}

variable "health_check_grace_period" {
  description = "Time in seconds, after instance comes into service before checking health"
  type        = number
  default     = 300
}

variable "enabled_metrics" {
  description = <<EOF
List of metrics to collect. 
The allowed values are as follows:
`GroupDesiredCapacity` 
`GroupInServiceCapacity`
`GroupPendingCapacity`
`GroupMinSize`
`GroupMaxSize`
`GroupInServiceInstances`
`GroupPendingInstances`
`GroupStandbyInstances`
`GroupStandbyCapacity`
`GroupTerminatingCapacity`
`GroupTerminatingInstances`
`GroupTotalCapacity`
`GroupTotalInstances`
EOF
  type        = list(string)
  default     = []
}

variable "metrics_granularity" {
  description = "Granularity to associate with the metrics to collect. The only valid value is `1Minute`"
  type        = string
  default     = "1Minute"
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
    description = "(Optional) If true, enables EC2 Instance Termination Protection."
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

variable "enable_monitoring" {
  description = "(Optional) Flag to decide if launched EC2 instance will have detailed monitoring enabled?"
  type        = bool
  default     = false
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance. Possible Values: `stop` or `terminate`."
  type        = string
  default     = "stop"
}

variable "ram_disk_id" {
  description = "(Optional) The ID of the RAM disk"
  type        = string
  default     = null
}

variable "user_data" {
  description = "The Base64-encoded user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
    description = "(Optional) A list of security group IDs to associate with."
    type        = list(string)
    default     = []
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
  type        = map(string)
  default     = {}
}

variable "asg_tags" {
  description = "(Optional) A map of tags to assign to Auto Scaling Group."
  type        = map(string)
  default     = {}
}

variable "instance_profile_tags" {
  description = "(Optional) A map of tags to assign to Instance Profile and role."
  type        = map(string)
  default     = {}
}

variable "launch_template_tags" {
  description = "(Optional) A map of tags to assign to Launch Template"
  type        = map(string)
  default     = {}
}

variable "as_resource_tags" {
  description = "(Optional) A map of tags to assign to the resources during launch"
  type        = list(any)
  default     = []
}
