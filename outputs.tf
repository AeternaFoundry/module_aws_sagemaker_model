output "sagemaker_models_id" {
  description = "Map of id values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.id if v.id != null && length(v.id) > 0 }
}
output "sagemaker_models_arn" {
  description = "Map of arn values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "sagemaker_models_container" {
  description = "Map of container values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.container if v.container != null && length(v.container) > 0 }
}
output "sagemaker_models_enable_network_isolation" {
  description = "Map of enable_network_isolation values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.enable_network_isolation if v.enable_network_isolation != null }
}
output "sagemaker_models_execution_role_arn" {
  description = "Map of execution_role_arn values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.execution_role_arn if v.execution_role_arn != null && length(v.execution_role_arn) > 0 }
}
output "sagemaker_models_inference_execution_config" {
  description = "Map of inference_execution_config values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => one(v.inference_execution_config) if v.inference_execution_config != null && length(v.inference_execution_config) > 0 }
}
output "sagemaker_models_name" {
  description = "Map of name values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.name if v.name != null && length(v.name) > 0 }
}
output "sagemaker_models_primary_container" {
  description = "Map of primary_container values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => one(v.primary_container) if v.primary_container != null && length(v.primary_container) > 0 }
}
output "sagemaker_models_region" {
  description = "Map of region values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.region if v.region != null && length(v.region) > 0 }
}
output "sagemaker_models_tags" {
  description = "Map of tags values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "sagemaker_models_tags_all" {
  description = "Map of tags_all values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "sagemaker_models_vpc_config" {
  description = "Map of vpc_config values across all sagemaker_models, keyed the same as var.sagemaker_models"
  value       = { for k, v in aws_sagemaker_model.sagemaker_models : k => one(v.vpc_config) if v.vpc_config != null && length(v.vpc_config) > 0 }
}

