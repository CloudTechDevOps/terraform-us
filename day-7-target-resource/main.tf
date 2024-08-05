

resource "aws_s3_bucket" "target" {
    bucket = "ytvhshfbbcaa" 
}

#terraform apply -target=aws_s3_bucket.dependent
#terraform destroy -target=aws_s3_bucket.dependent