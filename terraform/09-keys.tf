##################################### Creating Keys for VPN Instance #####################################




resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "vpn" {
  key_name   = "vpnKey"           
  public_key = tls_private_key.pk.public_key_openssh
  provisioner "local-exec" {      
  command = "echo '${tls_private_key.pk.private_key_pem}' > ./keys/vpnKey.pem"
  }
}


##################################### Creating Keys for ASG Instances #####################################



resource "tls_private_key" "nodeapp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "app" {
  key_name   = "nodeapp"  
  public_key = tls_private_key.nodeapp.public_key_openssh          
  provisioner "local-exec" {     
  command = "echo '${tls_private_key.nodeapp.private_key_pem}' > ./keys/nodeapp.pem"
  }
}
















##################################### Creating Keys for Mongo Instances #####################################


resource "tls_private_key" "mongo" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "db" {
  key_name   = "mongo" 
  public_key = tls_private_key.mongo.public_key_openssh
  provisioner "local-exec" {       
  command = "echo '${tls_private_key.mongo.private_key_pem}' > ./keys/mongo.pem"
  }
}