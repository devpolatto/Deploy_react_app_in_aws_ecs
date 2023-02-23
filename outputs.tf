output "Load_Balancer" {
  value = {
     "DNS Name React App" : aws_lb.application_load_balancer.dns_name
  }
}

# output "ECS_Cluster" {
#     value = {
#       "Nodes" : aws_ecs_service.frontend_service.desired_count,
#       "Network" : {
#         # "ELB" : aws_ecs_service.frontend_service.load_balancer.elb_name
#         "Subnets" :  {
#           for v in  aws_ecs_service.frontend_service.network_configuration.subnets: "subnet" => v
#         }      
#       }
#     }
# }