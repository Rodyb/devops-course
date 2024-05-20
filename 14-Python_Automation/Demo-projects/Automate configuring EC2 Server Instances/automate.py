import boto3


def tag_ec2_instances(tag_key, tag_value):
    ec2 = boto3.client('ec2', region_name='eu-central-1')
    response = ec2.describe_instances()

    instance_ids = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_ids.append(instance['InstanceId'])

    if instance_ids:
        ec2.create_tags(
            Resources=instance_ids,
            Tags=[
                {
                    'Key': tag_key,
                    'Value': tag_value
                }
            ]
        )
        print(f"Successfully tagged instances: {instance_ids}")
    else:
        print("No instances found.")


if __name__ == "__main__":
    tag_key = "Environment"
    tag_value = "Production"
    tag_ec2_instances(tag_key, tag_value)
