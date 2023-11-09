terraform {

}
provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = var.token
}

data "vault_generic_secret" "vault_example" {
  path = "secret/example"
}

output "vault_example" {
  value = nonsensitive(data.vault_generic_secret.vault_example.data.test) #функция nonsensitive позволяет узнать значение sensitive данных
}


## Записываем секрет
resource "vault_kv_secret_v2" "student" {
  mount               = "secret"
  name                = "student"
  data_json = jsonencode(
    {
      name = var.student.name,
      second_name = var.student.second_name
    }
  )
}

data "vault_generic_secret" "student" {
  path = "${vault_kv_secret_v2.student.mount}/${vault_kv_secret_v2.student.name}"
}

output "student" {
  value = nonsensitive(data.vault_generic_secret.student.data.second_name) #функция nonsensitive позволяет узнать значение sensitive данных
}