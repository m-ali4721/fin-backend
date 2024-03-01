resource "aws_instance" "server" {
  ami           = "ami-0d18e50ca22537278"
  instance_type = "t2.micro"
  key_name = "test-a2"

  tags = {
    Name = "Server"
  }
}