resource "aws_instance" "jenkins" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              # Update the package repository
              sudo yum update -y

              # Install Java
              sudo yum install -y java-1.8.0-openjdk

              # Add the Jenkins repository
              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

              # Install Jenkins
              sudo yum install -y jenkins

              # Start Jenkins
              sudo systemctl start jenkins
              sudo systemctl enable jenkins

              # Open the firewall for Jenkins
              sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
              sudo service iptables save
              EOF

  tags = {
    Name = "Jenkins"
  }
}

resource "aws_instance" "testing" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Testing"
  }
}

resource "aws_instance" "staging" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_c.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Staging"
  }
}

resource "aws_instance" "production1" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_d.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Production1"
  }
}

resource "aws_instance" "production2" {
  ami           = "ami-0440d3b780d96b29d" # Amazon Linux 2 AMI (HVM)
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_e.id
  security_groups = [aws_security_group.web_sg.id]
  key_name      = aws_key_pair.generated_key.key_name
  tags = {
    Name = "Production2"
  }
}
