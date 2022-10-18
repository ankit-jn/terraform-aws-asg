resource aws_autoscaling_group "this" {

    name = var.name
    min_size = var.min_size
    max_size = var.max_size
    vpc_zone_identifier = var.vpc_zone_identifier
    capacity_rebalance = var.capacity_rebalance
    protect_from_scale_in = var.protect_from_scale_in

    launch_template {
        name    = aws_launch_template.this.name
        version = aws_launch_template.this.latest_version
    }

    health_check_type = var.health_check_type
}