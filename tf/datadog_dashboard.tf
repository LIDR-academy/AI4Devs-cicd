resource "datadog_dashboard" "aws_dashboard" {
  title       = "AWS Overview Dashboard"
  description = "Dashboard for monitoring AWS resources"
  layout_type = "ordered"
  
  widget {
    group_definition {
      title = "AWS Overview"
      layout_type = "ordered"
      widget {
        timeseries_definition {
          title = "EC2 CPU Utilization"
          show_legend = true
          request {
            q = "avg:aws.ec2.cpuutilization{*} by {instance_id}"
            display_type = "line"
            style {
              palette = "dog_classic"
            }
          }
        }
      }
    }
  }

  widget {
    group_definition {
      title = "RDS Metrics"
      layout_type = "ordered"
      widget {
        query_value_definition {
          title = "RDS Free Storage Space"
          autoscale = true
          request {
            q = "min:aws.rds.free_storage_space{*}"
            aggregator = "last"
          }
        }
      }
    }
  }
}