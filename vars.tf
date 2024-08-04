variable "AWS_REGION" {
    default = "ap-south-1"
}


variable "AMI" {
    type = map

    default = {
        ap-south-1 = "ami-0f2e255ec956ade7f"
    }
}

variable "PUBLIC_KEY_PATH" {
    type = string
    default = "/home/dharsann/terraform/aws_vpc/mumbai-region-key-pair.pub"
}