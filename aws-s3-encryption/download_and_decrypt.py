import boto3
from cryptography.fernet import Fernet
import os

# Your AWS S3 bucket and file details
bucket_name = 'my-client-side-encryption-bucket'  # Replace with your bucket name
file_key = 'encrypted_file_3.txt'  # Replace with your file key in S3
downloaded_file_path = 'encrypted_file_3.txt'  # Where to download the file

# The same encryption key used for encrypting the file
encryption_key = "lRh-CgkvGlUocMgs8_0qTwMokXSDAaH_yr3yHJ6_-Uc="  # Replace with your encryption key
cipher_suite = Fernet(encryption_key)

# Initialize the S3 client
s3 = boto3.client('s3')

# Download the encrypted file from S3
s3.download_file(bucket_name, file_key, downloaded_file_path)
print(f"File downloaded from S3: {downloaded_file_path}")

# Decrypt the downloaded file
with open(downloaded_file_path, 'rb') as encrypted_file:
    encrypted_data = encrypted_file.read()

decrypted_data = cipher_suite.decrypt(encrypted_data)

# Write the decrypted data to a file
decrypted_file_path = './decrypted_file.txt'  # Path to save the decrypted file
with open(decrypted_file_path, 'wb') as decrypted_file:
    decrypted_file.write(decrypted_data)

print(f"File decrypted and saved: {decrypted_file_path}")
