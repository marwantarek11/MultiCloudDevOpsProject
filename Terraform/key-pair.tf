# tls generate key pair
# RSA key of size 4096 bits
resource "tls_private_key" "EC2-KEY" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "generated_key" {
  # key name represent the name of private key and publci key 
  key_name   = "EC2-KEY"
  public_key = tls_private_key.EC2-KEY.public_key_openssh
}