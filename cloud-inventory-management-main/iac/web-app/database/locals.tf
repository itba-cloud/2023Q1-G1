locals {
  partition_key = "userId"
  sort_key      = "itemId"

  attributes = {
    name      = "S"
    timestamp = "N"
  }
}

locals {
  read_max          = 10
  read_min          = 10
  write_max         = 10
  write_min         = 10
  read_target       = 10
  read_scalein_cd   = 300
  read_scaleout_cd  = 300
  write_target      = 10
  write_scalein_cd  = 300
  write_scaleout_cd = 300
}