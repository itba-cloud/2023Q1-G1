resource "aws_dynamodb_table" "inventory_table" {
  name           = var.db_name
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = "noteId"
    type = "S"
  }
  hash_key = "noteId"
  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true
    // false -> use AWS Owned CMK 
    // true -> use AWS Managed CMK 
    // true + key arn -> use custom key
  }
}

locals {
    read_max = 10
    read_min = 10
    write_max = 10
    write_min = 10
    read_target = 10
    read_scalein_cd = 300
    read_scaleout_cd = 300
    write_target = 10
    write_scalein_cd = 300
    write_scaleout_cd = 300
}

resource "aws_appautoscaling_target" "read_target" {
  max_capacity       = local.read_max
  min_capacity       = local.read_min
  resource_id        = "table/${var.db_name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_target" "write_target" {
  max_capacity       = local.write_max
  min_capacity       = local.write_min
  resource_id        = "table/${var.db_name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "read_policy" {
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.read_target.resource_id
  scalable_dimension = aws_appautoscaling_target.read_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.read_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value       = local.read_target
    scale_in_cooldown  = local.read_scalein_cd
    scale_out_cooldown = local.read_scaleout_cd
  }

  depends_on = [aws_appautoscaling_target.read_target]
}

resource "aws_appautoscaling_policy" "write_policy" {
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.write_target.resource_id
  scalable_dimension = aws_appautoscaling_target.write_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.write_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value       = local.write_target
    scale_in_cooldown  = local.write_scalein_cd
    scale_out_cooldown = local.write_scaleout_cd
  }

  depends_on = [aws_appautoscaling_target.write_target]
}
