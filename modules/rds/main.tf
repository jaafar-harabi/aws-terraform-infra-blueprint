variable "name"       { type = string }
variable "subnet_ids" { type = list(string) }
variable "username"   { type = string }
variable "password"   { type = string } 

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-rds-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "pg" {
  identifier             = "${var.name}-pg"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = true
  publicly_accessible    = false
}

output "rds_endpoint" { value = aws_db_instance.pg.address }
