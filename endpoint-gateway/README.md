
copy keypair to public ec2
```bash
scp -i "eni-ec2-demo.pem" "eni-ec2-demo.pem" ec2-user@ec2-44-223-14-84.compute-1.amazonaws.com:/home/ec2-user
```

ssh into jump host
```bash
ssh -i "ssh -i "eni-ec2-demo.pem" ec2-user@ec2-35-168-12-1.compute-1.amazonaws.com
```

then ssh into private ec2 with private ip
```bash
ssh -i "eni-ec2-demo.pem" ec2-user@10.0.5.85
```

dig com.amazonaws.us-east-1.dynamodb
