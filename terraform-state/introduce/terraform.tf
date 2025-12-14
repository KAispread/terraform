terraform {
  backend "s3" {
    bucket = "terraform-s3-state-kai"
    key          = "path/to/state"
    use_lockfile = true
    region = "ap-northeast-2"
  }
}
