variable "filename_set" {
  type = set(string)
  default = [ 
    "/tmp/4.txt",
    "/tmp/5.txt",
    "/tmp/6.txt"
  ]
}