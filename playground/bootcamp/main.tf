// specify version
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "> 2.4.0"
    }
  }
}

// iteration by `count`
resource "local_file" "test" {
    filename = var.filename_list[count.index]
    content = "test"
    file_permission = "0700"
    count = length(var.filename_list)

    // lifecycle
    lifecycle {
      create_before_destroy = true
    }
}

data "local_file" "world" {
  filename = "/tmp/world.txt"
}

variable "filename_list" {
    default = [
        "/tmp/1.txt",
        "/tmp/2.txt",
        "/tmp/3.txt"
    ]
}

// iteration by `count`
resource "local_file" "test_each" {
    filename = each.value
    content = "test"
    for_each = var.filename_set
}