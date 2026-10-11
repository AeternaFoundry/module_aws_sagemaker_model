resource "aws_sagemaker_model" "sagemaker_models" {
  for_each = var.sagemaker_models

  execution_role_arn       = each.value.execution_role_arn
  enable_network_isolation = each.value.enable_network_isolation
  name                     = each.value.name
  region                   = each.value.region
  tags                     = each.value.tags
  tags_all                 = each.value.tags_all

  dynamic "container" {
    for_each = each.value.container != null ? each.value.container : []
    content {
      dynamic "additional_model_data_source" {
        for_each = container.value.additional_model_data_source != null ? container.value.additional_model_data_source : []
        content {
          channel_name = additional_model_data_source.value.channel_name
          dynamic "s3_data_source" {
            for_each = additional_model_data_source.value.s3_data_source
            content {
              compression_type = s3_data_source.value.compression_type
              dynamic "model_access_config" {
                for_each = s3_data_source.value.model_access_config != null ? [s3_data_source.value.model_access_config] : []
                content {
                  accept_eula = model_access_config.value.accept_eula
                }
              }
              s3_data_type = s3_data_source.value.s3_data_type
              s3_uri       = s3_data_source.value.s3_uri
            }
          }
        }
      }
      container_hostname = container.value.container_hostname
      environment        = container.value.environment
      image              = container.value.image
      dynamic "image_config" {
        for_each = container.value.image_config != null ? [container.value.image_config] : []
        content {
          repository_access_mode = image_config.value.repository_access_mode
          dynamic "repository_auth_config" {
            for_each = image_config.value.repository_auth_config != null ? [image_config.value.repository_auth_config] : []
            content {
              repository_credentials_provider_arn = repository_auth_config.value.repository_credentials_provider_arn
            }
          }
        }
      }
      inference_specification_name = container.value.inference_specification_name
      mode                         = container.value.mode
      dynamic "model_data_source" {
        for_each = container.value.model_data_source != null ? [container.value.model_data_source] : []
        content {
          dynamic "s3_data_source" {
            for_each = model_data_source.value.s3_data_source
            content {
              compression_type = s3_data_source.value.compression_type
              dynamic "model_access_config" {
                for_each = s3_data_source.value.model_access_config != null ? [s3_data_source.value.model_access_config] : []
                content {
                  accept_eula = model_access_config.value.accept_eula
                }
              }
              s3_data_type = s3_data_source.value.s3_data_type
              s3_uri       = s3_data_source.value.s3_uri
            }
          }
        }
      }
      model_data_url     = container.value.model_data_url
      model_package_name = container.value.model_package_name
      dynamic "multi_model_config" {
        for_each = container.value.multi_model_config != null ? [container.value.multi_model_config] : []
        content {
          model_cache_setting = multi_model_config.value.model_cache_setting
        }
      }
    }
  }

  dynamic "inference_execution_config" {
    for_each = each.value.inference_execution_config != null ? [each.value.inference_execution_config] : []
    content {
      mode = inference_execution_config.value.mode
    }
  }

  dynamic "primary_container" {
    for_each = each.value.primary_container != null ? [each.value.primary_container] : []
    content {
      dynamic "additional_model_data_source" {
        for_each = primary_container.value.additional_model_data_source != null ? primary_container.value.additional_model_data_source : []
        content {
          channel_name = additional_model_data_source.value.channel_name
          dynamic "s3_data_source" {
            for_each = additional_model_data_source.value.s3_data_source
            content {
              compression_type = s3_data_source.value.compression_type
              dynamic "model_access_config" {
                for_each = s3_data_source.value.model_access_config != null ? [s3_data_source.value.model_access_config] : []
                content {
                  accept_eula = model_access_config.value.accept_eula
                }
              }
              s3_data_type = s3_data_source.value.s3_data_type
              s3_uri       = s3_data_source.value.s3_uri
            }
          }
        }
      }
      container_hostname = primary_container.value.container_hostname
      environment        = primary_container.value.environment
      image              = primary_container.value.image
      dynamic "image_config" {
        for_each = primary_container.value.image_config != null ? [primary_container.value.image_config] : []
        content {
          repository_access_mode = image_config.value.repository_access_mode
          dynamic "repository_auth_config" {
            for_each = image_config.value.repository_auth_config != null ? [image_config.value.repository_auth_config] : []
            content {
              repository_credentials_provider_arn = repository_auth_config.value.repository_credentials_provider_arn
            }
          }
        }
      }
      inference_specification_name = primary_container.value.inference_specification_name
      mode                         = primary_container.value.mode
      dynamic "model_data_source" {
        for_each = primary_container.value.model_data_source != null ? [primary_container.value.model_data_source] : []
        content {
          dynamic "s3_data_source" {
            for_each = model_data_source.value.s3_data_source
            content {
              compression_type = s3_data_source.value.compression_type
              dynamic "model_access_config" {
                for_each = s3_data_source.value.model_access_config != null ? [s3_data_source.value.model_access_config] : []
                content {
                  accept_eula = model_access_config.value.accept_eula
                }
              }
              s3_data_type = s3_data_source.value.s3_data_type
              s3_uri       = s3_data_source.value.s3_uri
            }
          }
        }
      }
      model_data_url     = primary_container.value.model_data_url
      model_package_name = primary_container.value.model_package_name
      dynamic "multi_model_config" {
        for_each = primary_container.value.multi_model_config != null ? [primary_container.value.multi_model_config] : []
        content {
          model_cache_setting = multi_model_config.value.model_cache_setting
        }
      }
    }
  }

  dynamic "vpc_config" {
    for_each = each.value.vpc_config != null ? [each.value.vpc_config] : []
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnets            = vpc_config.value.subnets
    }
  }
}

