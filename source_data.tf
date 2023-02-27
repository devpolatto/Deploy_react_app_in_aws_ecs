data "aws_ecr_repository" "ecr-repository" {
  name = "react-app"
}

data "aws_network_interfaces" "interfaces" {
  tags = {
    ALIAS_PROJECT = "Depoy React App in AWS ECS"
  }
}

data "template_file" "task_json" {
  template = file("task_template.json.tpl")

  vars = {
    container_name         = "${local.container_name}"
    container_image        = "${data.aws_ecr_repository.ecr-repository.repository_url}"
    container_port         = local.container_port
    container_host_port    = local.container_host_port
    container_memory_limit = local.container_memory_limit
    container_cpu_limit    = local.container_cpu_limit
  }
}