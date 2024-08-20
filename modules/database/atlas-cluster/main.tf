

resource "mongodbatlas_cluster" "cluster-atlas" {
  project_id                   = var.atlas_project_id
  name                         = var.context.name
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = var.mongo_db_major_version
  cluster_type                 = "REPLICASET"
  
  #Autoscaling sections
  auto_scaling_compute_enabled = var.auto_scaling_compute_enabled
  
  # when the autoscaling compute enabled set to true, this var is initiated (default to M20). otherwise - null
  provider_auto_scaling_compute_max_instance_size = var.auto_scaling_compute_enabled ? var.provider_auto_scaling_compute_max_instance_size : null 
    
  # when the autoscaling compute enabled set to true, this var is initiated (default to true). otherwise - null
  auto_scaling_compute_scale_down_enabled = var.auto_scaling_compute_enabled ? var.auto_scaling_compute_scale_down_enabled : null

  # when the autoscaling compute enabled set to true, this var is initiated (default to M10). otherwise - null
  provider_auto_scaling_compute_min_instance_size = var.auto_scaling_compute_enabled ? var.provider_auto_scaling_compute_min_instance_size : null


  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = upper(replace(var.region, "-", "_")) # e.g. eu-west-1 => EU_WEST_1
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }

  advanced_configuration {
    javascript_enabled           = false
    minimum_enabled_tls_protocol = "TLS1_2"
  }
  # Provider settings
  provider_name               = "AWS"
  disk_size_gb                = 10
  provider_instance_size_name = var.provider_instance_size_name
}


