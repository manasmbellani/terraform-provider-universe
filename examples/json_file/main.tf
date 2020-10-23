terraform {
  required_version = ">= 0.13.0"
  required_providers {
    multiverse = {
      source = "github.com/mobfox/multiverse"
      version = ">=0.0.1"
    }
    linux = {
      source = "github.com/mobfox/linux"
      version = ">=0.0.1"
    }
  }
}
provider "multiverse" {
  executor = "python3"
  script = "json_file.py"
  id_key = "filename"
  environment = {
    api_token = "redacted"
    servername = "api.example.com"
    api_token = "redacted"
  }
  computed = jsonencode([
    "created"])
}

resource "multiverse_json_file" "h" {
  config = jsonencode({
    "name": "Don't Step On My Blue Suede Shoes",
    "created-by" : "Elvis Presley",
    "where" : "Gracelands"
    "hit" : "Gold"

  })
}

resource "multiverse_json_file" "hp" {
  config = jsonencode({
    "name": "Another strange resource",
    "main-character" : "Harry Potter",
    "nemesis" : "Tom Riddle",
    "likes" : [
      "Ginny Weasley",
      "Ron Weasley"
    ]
  })
}

resource "linux_json_file" "i" {
  executor = "python3"
  script = "json_file.py"
  id_key = "filename"
  computed = jsonencode(["created"])
  config = jsonencode({
    "name": "Fake strange resource"
  })
}

output "hp_name" {
  value = jsondecode(multiverse_json_file.hp.config)["name"]
}

output "hp_created" {
  value = jsondecode(multiverse_json_file.hp.dynamic)["created"]
}