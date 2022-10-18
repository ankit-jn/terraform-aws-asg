resource aws_launch_template "this" {
    name        = local.instance_template_name
    description = var.launch_template_description
    image_id    = var.image_id

    instance_type = var.instance_type
    user_data   = var.user_data


    ## Additional Volumes to be attached with EC2 instance
    dynamic "block_device_mappings" {
        for_each = var.block_device_mappings
        iterator = device

        content {
            device_name  = device.value.name
            no_device    = try(device.value.no_device, null)
            virtual_name = try(device.value.virtual_name, null)

            ebs {
                delete_on_termination = lookup(device.value, "ebs_delete_on_termination", false)
                encrypted             = (lookup(device.value, "ebs_snapshot_id", "") == "") ? lookup(device.value, "ebs_encrypted", false) : false
                kms_key_id            = lookup(device.value, "ebs_encrypted", false) ?  try(device.value.ebs_kms_key_id, null) :  null
                snapshot_id           = lookup(device.value, "ebs_encrypted", false) ? null : try(device.value.ebs_snapshot_id, null)
                volume_size           = try(device.value.ebs_volume_size, null)
                volume_type           = lookup(device.value, "ebs_volume_type", "gp2")
                iops                  = try(device.value.ebs_iops, null)
                throughput            = try(device.value.ebs_ebs_throughput, null)
            }
        }
    }

    ## CPU Options for EC2 Instance
    dynamic "cpu_options" {
        for_each = length(keys(var.cpu_options)) > 0 ? [1] : []

        content {
            core_count       = lookup(var.cpu_options, "core_count", 1)
            threads_per_core = lookup(var.cpu_options, "threads_per_core", 2)
        }
    }
    
    ## Credit specification of EC2 Instance
    dynamic "credit_specification" {
        for_each = can(var.cpu_credits) && var.cpu_credits != "" ? [1] : []
        
        content {
          cpu_credits = var.cpu_credits
        }
    }

    dynamic "iam_instance_profile" {
        for_each = var.create_instance_profile ? [1] : []
        content {
            arn     = aws_iam_instance_profile.this[0].arn
        }
    }
}
