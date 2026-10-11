variable "sagemaker_models" {
  description = <<EOT
Map of sagemaker_models, attributes below
Required:
    - execution_role_arn
Optional:
    - enable_network_isolation
    - name
    - region
    - tags
    - tags_all
    - container (block):
        - additional_model_data_source (optional, block):
            - channel_name (required)
            - s3_data_source (required, block):
                - compression_type (required)
                - model_access_config (optional, block):
                    - accept_eula (required)
                - s3_data_type (required)
                - s3_uri (required)
        - container_hostname (optional)
        - environment (optional)
        - image (optional)
        - image_config (optional, block):
            - repository_access_mode (required)
            - repository_auth_config (optional, block):
                - repository_credentials_provider_arn (required)
        - inference_specification_name (optional)
        - mode (optional)
        - model_data_source (optional, block):
            - s3_data_source (required, block):
                - compression_type (required)
                - model_access_config (optional, block):
                    - accept_eula (required)
                - s3_data_type (required)
                - s3_uri (required)
        - model_data_url (optional)
        - model_package_name (optional)
        - multi_model_config (optional, block):
            - model_cache_setting (optional)
    - inference_execution_config (block):
        - mode (required)
    - primary_container (block):
        - additional_model_data_source (optional, block):
            - channel_name (required)
            - s3_data_source (required, block):
                - compression_type (required)
                - model_access_config (optional, block):
                    - accept_eula (required)
                - s3_data_type (required)
                - s3_uri (required)
        - container_hostname (optional)
        - environment (optional)
        - image (optional)
        - image_config (optional, block):
            - repository_access_mode (required)
            - repository_auth_config (optional, block):
                - repository_credentials_provider_arn (required)
        - inference_specification_name (optional)
        - mode (optional)
        - model_data_source (optional, block):
            - s3_data_source (required, block):
                - compression_type (required)
                - model_access_config (optional, block):
                    - accept_eula (required)
                - s3_data_type (required)
                - s3_uri (required)
        - model_data_url (optional)
        - model_package_name (optional)
        - multi_model_config (optional, block):
            - model_cache_setting (optional)
    - vpc_config (block):
        - security_group_ids (required)
        - subnets (required)
EOT

  type = map(object({
    execution_role_arn       = string
    enable_network_isolation = optional(bool)
    name                     = optional(string)
    region                   = optional(string)
    tags                     = optional(map(string))
    tags_all                 = optional(map(string))
    container = optional(list(object({
      additional_model_data_source = optional(list(object({
        channel_name = string
        s3_data_source = list(object({
          compression_type = string
          model_access_config = optional(object({
            accept_eula = bool
          }))
          s3_data_type = string
          s3_uri       = string
        }))
      })))
      container_hostname = optional(string)
      environment        = optional(map(string))
      image              = optional(string)
      image_config = optional(object({
        repository_access_mode = string
        repository_auth_config = optional(object({
          repository_credentials_provider_arn = string
        }))
      }))
      inference_specification_name = optional(string)
      mode                         = optional(string)
      model_data_source = optional(object({
        s3_data_source = list(object({
          compression_type = string
          model_access_config = optional(object({
            accept_eula = bool
          }))
          s3_data_type = string
          s3_uri       = string
        }))
      }))
      model_data_url     = optional(string)
      model_package_name = optional(string)
      multi_model_config = optional(object({
        model_cache_setting = optional(string)
      }))
    })))
    inference_execution_config = optional(object({
      mode = string
    }))
    primary_container = optional(object({
      additional_model_data_source = optional(list(object({
        channel_name = string
        s3_data_source = list(object({
          compression_type = string
          model_access_config = optional(object({
            accept_eula = bool
          }))
          s3_data_type = string
          s3_uri       = string
        }))
      })))
      container_hostname = optional(string)
      environment        = optional(map(string))
      image              = optional(string)
      image_config = optional(object({
        repository_access_mode = string
        repository_auth_config = optional(object({
          repository_credentials_provider_arn = string
        }))
      }))
      inference_specification_name = optional(string)
      mode                         = optional(string)
      model_data_source = optional(object({
        s3_data_source = list(object({
          compression_type = string
          model_access_config = optional(object({
            accept_eula = bool
          }))
          s3_data_type = string
          s3_uri       = string
        }))
      }))
      model_data_url     = optional(string)
      model_package_name = optional(string)
      multi_model_config = optional(object({
        model_cache_setting = optional(string)
      }))
    }))
    vpc_config = optional(object({
      security_group_ids = set(string)
      subnets            = set(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.container == null || alltrue([for item in v.container : (item.additional_model_data_source == null || alltrue([for item in item.additional_model_data_source : (length(item.s3_data_source) >= 1)]))])
      )
    ])
    error_message = "Each s3_data_source list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.container == null || alltrue([for item in v.container : (item.model_data_source == null || (length(item.model_data_source.s3_data_source) >= 1))])
      )
    ])
    error_message = "Each s3_data_source list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.primary_container == null || (v.primary_container.additional_model_data_source == null || alltrue([for item in v.primary_container.additional_model_data_source : (length(item.s3_data_source) >= 1)]))
      )
    ])
    error_message = "Each s3_data_source list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.primary_container == null || (v.primary_container.model_data_source == null || (length(v.primary_container.model_data_source.s3_data_source) >= 1))
      )
    ])
    error_message = "Each s3_data_source list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.container == null || alltrue([for item in v.container : (item.container_hostname == null || (length(item.container_hostname) <= 63))])
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.container == null || alltrue([for item in v.container : (item.image == null || (length(item.image) <= 255))])
      )
    ])
    error_message = "[from validImage: invalid when len(value) > 255]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.container == null || alltrue([for item in v.container : (item.inference_specification_name == null || (length(item.inference_specification_name) <= 63))])
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.primary_container == null || (v.primary_container.container_hostname == null || (length(v.primary_container.container_hostname) <= 63))
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.primary_container == null || (v.primary_container.image == null || (length(v.primary_container.image) <= 255))
      )
    ])
    error_message = "[from validImage: invalid when len(value) > 255]"
  }
  validation {
    condition = alltrue([
      for k, v in var.sagemaker_models : (
        v.primary_container == null || (v.primary_container.inference_specification_name == null || (length(v.primary_container.inference_specification_name) <= 63))
      )
    ])
    error_message = "[from validName: invalid when len(value) > 63]"
  }
  # Note: 47 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

