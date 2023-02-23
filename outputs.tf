output "Deploy_Success" {
  value = {
    "Cluster_name" : aws_ecs_cluster.ecs_cluster.name,
    "URL" : aws_lb.application_load_balancer.dns_name
    "Network" : {
        "Subnets" :  [for v in aws_ecs_service.frontend_service.network_configuration: v.subnets]    
    }
    "task" : {
      "Nodes" : aws_ecs_service.frontend_service.desired_count,
    }
  }
}