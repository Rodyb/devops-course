import requests
import paramiko
import schedule
import time

server_url = 'http://172.233.47.23:8080/'
linode_ip = '172.233.47.23'
ssh_user = 'root'
ssh_key_path = '/Users/rodybothe/.ssh/digital_ocean_macbook'
teams_webhook_url = '<some webhook>'
docker_container_name = 'nginx_test'

def send_teams_notification(message):
    headers = {
        'Content-Type': 'application/json'
    }
    payload = {
        'text': message
    }
    requests.post(teams_webhook_url, json=payload, headers=headers)


def restart_server():
    print('Restarting the application...')
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(hostname=f"{linode_ip}", username=f"{ssh_user}", key_filename=f"{ssh_key_path}")
    stdin, stdout, stderr = ssh.exec_command(f"docker start {docker_container_name}")
    print(stdout.readlines())
    ssh.close()


def check_server():
    try:
        print("Checking server status...")
        response = requests.get(server_url)
        if response.status_code == 200:
            print(f"Server is running and giving {response.status_code}.")
        else:
            raise Exception(f"Server returned a non-200 status code: {response.status_code}")

    except Exception as e:
        print(f"Server is down: {e}")
        send_teams_notification(f"The server at {server_url} is down. Error: {e}")
        restart_server()


schedule.every(5).seconds.do(check_server)

while True:
    schedule.run_pending()
    time.sleep(1)
