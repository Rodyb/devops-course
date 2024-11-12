import boto3

def get_eks_clusters():
    eks = boto3.client('eks', region_name='us-west-2')
    clusters = eks.list_clusters()
    return clusters['clusters']

def describe_eks_cluster(cluster_name):
    eks = boto3.client('eks', region_name='eu-central-1')
    response = eks.describe_cluster(name=cluster_name)
    cluster_info = response['cluster']
    print(f"Cluster info : ${cluster_info}")

if __name__ == "__main__":
    clusters = get_eks_clusters()
    if clusters:
        for cluster_name in clusters:
            describe_eks_cluster(cluster_name)
    else:
        print("No EKS clusters found.")
