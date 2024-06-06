module "frontend-lb" {
  source             = "../Modules/Load-Balancer"
  load_balancer_name = "frontend-three-tier-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.sg.id]
  subnets            = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_2]
  Environment        = "dev"
  target_group_name  = "frontend-lb-tg"
  target_group_port  = "80"
  protocol           = "HTTP"
  vpc_id             = module.vpc.vpc_id
}


module "frontend-ALB" {
  source                 = "../Modules/ASG"
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  key_name               = "Soham"
  instance_name          = "frontend-dev-instances"
  Environment            = "dev"
  security_groups        = [module.sg.id]
  alb_group_name         = "three-tier-asg-frontend"
  max_size               = 2
  min_size               = 1
  desired_capacity       = 1
  lb_target_group_arns   = [module.frontend-lb.target_group_arn]
  subnets_alb            = [module.vpc.public_subnet_id, module.vpc.public_subnet_id_2]
  asg_policy_name        = "three-tier-asg-policy-frontend"
  policy_type            = "TargetTrackingScaling"
  predefined_metric_type = "ASGAverageCPUUtilization"
  target_value           = 50
  health_check_type      = "ELB"
}

module "backend-lb" {
  source             = "../Modules/Load-Balancer"
  load_balancer_name = "backend-three-tier-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [module.sg.id]
  subnets            = [module.vpc.private_subnet_id, module.vpc.private_subnet_id_2]
  Environment        = "dev"
  target_group_name  = "backend-lb-tg"
  target_group_port  = "80"
  protocol           = "HTTP"
  vpc_id             = module.vpc.vpc_id
}

module "backend-ALB" {
  source                 = "../Modules/ASG"
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  key_name               = "Soham"
  instance_name          = "backend-dev-instances"
  Environment            = "dev"
  security_groups        = [module.sg.id]
  alb_group_name         = "three-tier-asg-backend"
  max_size               = 2
  min_size               = 1
  desired_capacity       = 1
  lb_target_group_arns   = [module.backend-lb.target_group_arn]
  subnets_alb            = [module.vpc.private_subnet_id, module.vpc.private_subnet_id_2]
  asg_policy_name        = "three-tier-asg-policy-backend"
  policy_type            = "TargetTrackingScaling"
  predefined_metric_type = "ASGAverageCPUUtilization"
  target_value           = 50
  health_check_type      = "ELB"
}

module "sg" {
  source      = "../Modules/Security_groups"
  vpc_id      = module.vpc.vpc_id
  name        = "test-sg"
  description = "a test sg"

  ingress_rules = [
    {
      description = "HTTP Port"
      from_port   = "80"
      to_port     = "80"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "SSH Port"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "MYSQL Port"
      from_port   = "3306"
      to_port     = "3306"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Backend Port"
      from_port   = "3000"
      to_port     = "3000"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "vpc" {
  source                          = "../Modules/VPC"
  vpc_cidr                        = "10.0.0.0/16"
  vpc_name                        = "three-tier-VPC"
  public_subnet_cidr_block        = "10.0.0.0/24"
  public_subnet_name              = "Three-tier-Public-Subnet"
  public_sub_availability_zone    = "us-east-1a"
  private_subnet_cidr_block       = "10.0.1.0/24"
  private_subnet_name             = "Three-tier-Private-subnet"
  private_sub_availability_zone   = "us-east-1b"
  public_subnet_cidr_block_2      = "10.0.2.0/24"
  public_subnet_name_2            = "Three-tier-Public-Subnet-2"
  public_sub_availability_zone_2  = "us-east-1b"
  private_subnet_cidr_block_2     = "10.0.3.0/24"
  private_subnet_name_2           = "Three-tier-Private-subnet-2"
  private_sub_availability_zone_2 = "us-east-1a"
}

module "rds" {
  source                   = "../Modules/RDS"
  identifier               = "three-tier-db-dev"
  allocated_storage        = 10
  db_name                  = "ThreeTierDb"
  db_engine                = "mysql"
  db_engine_version        = "8.0"
  instance_type            = "db.t3.micro"
  rds_username             = "soham"
  subnet_group_name        = "three-tier-subnet-group"
  subnet_ids               = [module.vpc.private_subnet_id, module.vpc.private_subnet_id_2]
  skip_final_snapshot      = true
  security_group_ids       = [module.sg.id]
  Environment              = "dev"
  rds_password_secret_name = "my_rds_password_1"
  identifier_replica       = "three-tier-db-dev-replica"
  backup_retention_period  = 7
}