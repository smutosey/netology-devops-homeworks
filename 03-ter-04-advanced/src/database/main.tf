terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">=0.13"
    }
  }
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = var.cluster_id
  name       = var.db_name
}


resource "yandex_mdb_mysql_user" "db_user" {
  cluster_id = var.cluster_id
  name       = var.username
  password   = var.password

  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = ["ALL"]
  }
}