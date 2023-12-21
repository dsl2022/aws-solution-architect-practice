import boto3
import os
import json

ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    # Get instance IDs from environment variables
    
    
    eni_id = os.environ['ENI_ID']
    # Get the state of the instance that triggered the Lambda and define the instance
    instance_state = event['detail']['state']
    if instance_state == 'started':
        instance_id = os.environ['PRIMARY_INSTANCE_ID']
    else:
        instance_id = os.environ['STANDBY_INSTANCE_ID']
    print(f"Triggered by instance state change: {instance_state}")

    # Extract ENI ID from the event (assuming it's passed in the event)
    # eni_id = event['resources'][0]
    print("event",event)
    try:
        # Describe the network interface to get the attachment ID
        response = ec2.describe_network_interfaces(NetworkInterfaceIds=[eni_id])
        if 'Attachment' in response['NetworkInterfaces'][0]:
            attachment = response['NetworkInterfaces'][0]['Attachment']
            attachment_id = attachment['AttachmentId']

            # Detach the ENI
            ec2.detach_network_interface(AttachmentId=attachment_id, Force=True)
            print(f"Detaching ENI {eni_id} with attachment ID {attachment_id}")

            # Wait for ENI to be available
            waiter = ec2.get_waiter('network_interface_available')
            waiter.wait(NetworkInterfaceIds=[eni_id])
            print(f"ENI {eni_id} is now available")
        else:
            print(f"ENI {eni_id} is already detached")

        # Attach the ENI to the standby instance
        attach_response = ec2.attach_network_interface(
            NetworkInterfaceId=eni_id,
            InstanceId=instance_id,
            DeviceIndex=1
        )
        print(f"Attached ENI {eni_id} to instance {instance_id}")

    except Exception as e:
        print(f"Error: {str(e)}")
        raise e

    return {
        'statusCode': 200,
        'body': json.dumps('ENI reattachment process completed.')
    }
