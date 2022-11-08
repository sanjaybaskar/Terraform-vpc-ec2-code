output "vpc_id"{
    value = aws_vpc.myvpc1.id
}

output "pubsub_id"{
value = aws_subnet.mypubsub.id
}

output "prvtsub_id"{
    value = aws_subnet.myprivsub.id
}

