variable "region" {
  type    = string
  default = "eu-west-2"
}
variable "project" {
  type    = string
  default = "morays-eks"
}
variable "node_instance_type" {
  type    = string
  default = "m7i-flex.large"
}
variable "node_desired" {
  type    = number
  default = 2
}
variable "node_min" {
  type    = number
  default = 1
}
variable "node_max" {
  type    = number
  default = 3
}
variable "cluster_public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}