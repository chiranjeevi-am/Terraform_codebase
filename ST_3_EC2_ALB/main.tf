provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "bastion" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.medium"
  subnet_id     = "subnet-0408659c2540ca84e"

  ingress{
	description = "allow ssh"
	from_port   = 22
	to_port		= 22
	protocol	= "tcp"
	cidr_blocks	= ["0.0.0.0/0"]
  }
  
  egress{
	from_port 	= 0
	to_port		= 0
	protocol	= "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags= {
    Name        = "Bastion"
    Terraform   = "true"
    Environment = "dev"
  }

}

resource "aws_instance" "Jenkins" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.medium"
  subnet_id     = "subnet-0ee6f7309997c2b9a"

  tags= {
    Name        = "Jenkins"
    Terraform   = "true"
    Environment = "dev"
  }

}

resource "aws_instance" "app" {
  ami           = "ami-04505e74c0741db8d"
  instance_type = "t2.medium"
  subnet_id     = "subnet-053159d9aaff2fa0f"

  tags= {
    Name        = "app"
    Terraform   = "true"
    Environment = "dev"
  }

}

resource "aws_lb" "alb" {
  name               = "chiranjeeviam-alb"
  internal           = false
  load_balancer_type = "application"

  tags = {
    Name        = "Chiranjeeviam-alb"
    Terraform   = "true"
    Environment = "dev"
  }
}
