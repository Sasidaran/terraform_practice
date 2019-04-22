provider "aws" {
  region  = "${var.region}"
}

resource "aws_instance" "sample_tf_resource" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "subnet-1ce55050"

  provisioner "local-exec" {
    command = "echo ${aws_instance.sample_tf_resource.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.sample_tf_resource.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
