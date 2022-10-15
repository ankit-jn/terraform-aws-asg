locals {
    instance_template_name = coalesce(var.launch_template_name, format("%s-template", var.name))
    instance_profile_name = coalesce(var.instance_profile_name, format("%s-instance-profile", var.name))

    instance_profile_policy_names = [for policy in var.instance_profile_policies: policy.name]
    
    instance_profile_roles = [
                        {
                            name = local.instance_profile_name
                            description = "IAM Role for ECS Container Agent running on EC2 instances with trusted Entity - EC2 Service"
                            service_names = [
                                "ec2.amazonaws.com"
                            ]  
                            policy_map = {
                                policy_names = local.instance_profile_policy_names
                                policy_arns = var.instance_profile_policy_arns
                            }   
                                            
                        }
    ]
}