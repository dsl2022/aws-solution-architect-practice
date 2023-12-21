#!/bin/zsh

echo example text >> example.txt

openssl rand -out encryption_key.bin 32

aws s3api put-object --bucket my-sse-c-bucket --key example.txt --body example.txt --sse-customer-algorithm AES256 --sse-customer-key fileb://encryption_key.bin

aws s3api get-object --bucket my-sse-c-bucket --key example.txt example_downloaded.txt --sse-customer-algorithm AES256 --sse-customer-key fileb://encryption_key.bin
