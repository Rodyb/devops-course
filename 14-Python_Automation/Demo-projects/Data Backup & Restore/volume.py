import boto3
import datetime


def create_volume_snapshots():
    ec2 = boto3.client('ec2', region_name='eu-central-1')
    volumes = ec2.describe_volumes()

    for volume in volumes['Volumes']:
        volume_id = volume['VolumeId']
        description = f"Backup of {volume_id} taken on {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"

        response = ec2.create_snapshot(
            VolumeId=volume_id,
            Description=description
        )
        print(f"Snapshot for volume {volume_id} created: {response['SnapshotId']}")


if __name__ == "__main__":
    create_volume_snapshots()
