locals {
  region = "" # região da infraestrutura cloud
  profile = "" # profile default ou personalizado em seu .aws/credentials
  vpc_id = "" # id da VPC ex: vpc-02b50xxxxxxxxxxxx
  igw_id = "" # id do Internet gateway ex: igw-02e2c9xxxxxxxxxxx
}

locals {
  container_port   = # 80
  container_host_port    = # 80
  container_memory_limit = # 512
  container_cpu_limit    = # 256
}
