import boto3
from cryptography.fernet import Fernet
import os

# Generate a key for encryption
key = Fernet.generate_key()
cipher_suite = Fernet(key)

with open("client_side_encryption_key.txt",'wb') as file:
    file.write(key)

# Encrypt the file
file_to_encrypt = 'file.txt'
with open(file_to_encrypt, 'rb') as file:
    file_data = file.read()
encrypted_data = cipher_suite.encrypt(file_data)

# Write the encrypted file to disk
encrypted_file_path = 'encrypted_file_3.txt'
with open(encrypted_file_path, 'wb') as file:
    file.write(encrypted_data)

# Upload the encrypted file to S3
s3 = boto3.client('s3')
bucket_name = 'my-client-side-encryption-bucket'  # Replace with your bucket name
s3.upload_file(encrypted_file_path, bucket_name, os.path.basename(encrypted_file_path))

print("File encrypted and uploaded successfully.")