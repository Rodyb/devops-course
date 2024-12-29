import boto3
import time


def get_ec2_statuses():
    ec2 = boto3.client('ec2', region_name='eu-central-1')
    response = ec2.describe_instance_status()

    for instance in response['InstanceStatuses']:
        print(
            f"Instance ID: {instance['InstanceId']}, State: {instance['InstanceState']['Name']}, Status: {instance['InstanceStatus']['Status']}")


def monitor_ec2_statuses(interval):
    while True:
        print("Checking EC2 statuses...")
        get_ec2_statuses()
        time.sleep(interval)


if __name__ == "__main__":
    interval = 60
    monitor_ec2_statuses(interval)
