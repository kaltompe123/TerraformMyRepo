resource "aws_instance" "testname" {
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t3.nano"
}

resource "aws_instance" "testname1" {
  ami           = "ami-02457590d33d576c3"
  instance_type = "t2.micro"
}

##rpm -qa 
#dgdjd
#
#51861 
#hskksh
#failed 