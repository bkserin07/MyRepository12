
resource "aws_instance" "jenkins" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.jenkins_key.key_name
  subnet_id     = module.networking.subnet_ids[0]
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "testing" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.jenkins_key.key_name
  subnet_id     = module.networking.subnet_ids[0]
  tags = {
    Name = "Testing"
  }
}

resource "aws_instance" "staging" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.jenkins_key.key_name
  subnet_id     = module.networking.subnet_ids[0]
  tags = {
    Name = "Staging"
  }
}

resource "aws_instance" "prod_1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.jenkins_key.key_name
  subnet_id     = module.networking.subnet_ids[0]
  tags = {
    Name = "Production 1"
  }
}

resource "aws_instance" "prod_2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.jenkins_key.key_name
  subnet_id     = module.networking.subnet_ids[0]
  tags = {
    Name = "Production 2"
  }
}

output "jenkins_instance_url" {
  value = aws_instance.jenkins.public_ip
}
