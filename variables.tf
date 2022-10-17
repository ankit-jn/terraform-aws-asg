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
    description = "(Optional, default false) Whether capacity rebalance is enabled."
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

### Launch template Specific Variables
 
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

variable "create_instance_profile" {
    description = "Decide is an IAM instance profile is created"     
    type        = bool 
    default     = false
}

variable "instance_profile_name" {
    description = "The name of the instance profile"  
    type        = string
    default     = ""   
}

variable "instance_profile_path" {
    description = "(Optional, default \"/\") Path to the instance profile."  
    type        = string
    default = "/" 
}

variable "create_instance_profile_role" {
    description = "(Optional) Decide to create new role for Instance Profile or to use existing IAMrole"
    type        = bool
    default     = true
}

variable "instance_profile_role_arn" {
    description = "(Optional) ARN of the IAM role if `craete_role` is false"
    type        = string  
    default     = ""
}

variable "instance_profile_policies" {
  description = "(Optional, default `[]`) List of Policies (to be provisioned) to be attached to Instance profile"
  default = []
}

## Tags
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
