resource "aws_instance" "server" {
  ami           = "ami-0c0d141edc4f470cc"
  instance_type = "t2.micro"
  key_name      = "123"
  user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname C8.local
              EOF
  tags = {
    Name = "C8.local"
  }
}
resource "aws_instance" "server-backend" {
  ami           = "ami-08e2c1a8d17c2fe17"
  instance_type = "t2.micro"
  key_name      = "123"
    user_data = <<-EOF
              #!/bin/bash
              hostnamectl set-hostname U21.local
              EOF
  tags = {
    Name = "U21.local"
  }
}
resource "local_file" "inventory" {
  filename = "./inventory.yaml"
  content  = <<EOF
[frontend]
${aws_instance.server.public_ip}
[backend]
${aws_instance.server-backend.public_ip}
EOF
}


output "frontend_public_ip" {
  value = aws_instance.server.public_ip
}
output "backend_public_ip" {
  value = aws_instance.server-backend.public_ip
}