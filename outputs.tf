output "arn" {
    description = "ARN of Auto Scaling Group"
    value = aws_autoscaling_group.this.arn
}

output "instance_profile_role_arn" {
    description = "ARN of IAM role provisioned for Instance Profile"
    value = var.create_instance_profile ? module.instance_profile_role[0].service_linked_roles[var.instance_profile_name].arn : ""
}

output "instance_profile_arn" {
    description = "ARN of IAM Instance Profile"
    value = var.create_instance_profile ? aws_iam_instance_profile.this[0].arn : ""
}

output "launch_template" {
    description = "Launch Template"
    value = {
        id  = aws_launch_template.this.id
        arn = aws_launch_template.this.arn
    }
}