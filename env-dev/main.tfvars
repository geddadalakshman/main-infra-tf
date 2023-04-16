env = "dev"

vpc = {
  main = {
    vpc_cidr = 10.0.0.0/16

    public_subnets = {
      public = {
        name = "${var.env}-public"
        cidr_block = [ 10.0.1.0/24, 10.0.2.0/24 ]
      }
    }

    private_subnets = {
      web = {
        name = "${var.env}-web"
        cidr_block = [ 10.0.3.0/24, 10.0.4.0/24 ]
      }
      app = {
        name = "${var.env}-app"
        cidr_block = [ 10.0.5.0/24 , 10.0.6.0/24 ]
      }
      db = {
        name = "${var.env}-db"
        cidr_block = [ 10.0.7.0/24 , 10.0.8.0/24 ]
      }
    }

  }
}