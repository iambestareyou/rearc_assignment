resource "aws_instance" "one" {
  ami           = var.image
  instance_type = var.instance_type
  key_name = "new1"
  subnet_id = var.subnet_id

  user_data = <<EOF
	#! /bin/bash
    sudo yum update -y && sudo yum install docker git -y
	sudo systemctl start docker && systemctl enable docker
	sudo mkdir -p /home/ec2-user/new/quest
	git clone https://github.com/rearc/quest.git /home/ec2-user/new/quest/
    echo "cd /home/ec2-user/new/quest/" >> /tmp/test1.sh
    echo "sudo cp /tmp/Dockerfile /home/ec2-user/new/quest/Dockerfile" >> /tmp/test1.sh
    echo "cd /home/ec2-user/new/quest/" >> /tmp/test1.sh
    echo "sudo docker build -t iambestareyou/node-web-app -f /home/ec2-user/new/quest/Dockerfile ." >> /tmp/test1.sh
    echo "sudo docker run -p 80:3000 -e SECRET_WORD='TwelveFactor' -d iambestareyou/node-web-app" >> /tmp/test1.sh
    EOF

  tags = {
    Name = var.name
  }

    provisioner "file" {
    source      = "C:\\Users\\Admin\\Desktop\\rearc_terra\\Dockerfile.txt"
    destination = "/tmp/Dockerfile"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("C:\\Users\\Admin\\Downloads\\new1.pem")}"
      host        = "${self.public_dns}"
    }
  }

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("C:\\Users\\Admin\\Downloads\\new1.pem")}"
      host        = "${self.public_dns}"
    }

    provisioner "remote-exec" {
        inline=[
            "sleep 60",
            "sudo /bin/bash /tmp/test1.sh"
        ]
      
    }
}