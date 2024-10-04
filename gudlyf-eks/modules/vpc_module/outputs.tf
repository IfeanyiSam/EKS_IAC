output "vpc_id" {
  description = "The ID of the VPC"
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value = module.vpc.private_subnets
}

output "database_subnet_ids" {
  description = "The IDs of the database subnets"
  value = module.vpc.database_subnets
}

output "public_subnet_az" {
  description = "AZ of public subnet"
  value = var.public_subnet_az
}