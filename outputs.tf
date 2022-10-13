output "instance_profile_role_arn" {
    value = var.create_instance_profile ? module.iam_instance_profile[0].service_linked_roles[var.instance_profile_name].arn : ""
}

output "instance_profile_arn" {
    value = var.create_instance_profile ? aws_iam_instance_profile.this[0].arn : ""
}

output "arn" {
    value = aws_autoscaling_group.this.arn
}

output "launch_template" {
    value = {
        id  = aws_launch_template.this.id
        arn = aws_launch_template.this.arn
    }
}