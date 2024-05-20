import requests

def get_gitlab_repositories(username):
    url = f"https://gitlab.com/api/v4/users/{username}/projects"
    response = requests.get(url)
    if response.status_code == 200:
        repositories = response.json()

        for repo in repositories:
            print(f"Repository: {repo['name']}\nURL: {repo['web_url']}\n")
    else:
        print(f"Error: Unable to fetch repositories. Status Code: {response.status_code}")

def main():
    gitlab_username = input("Enter GitLab username: ")
    get_gitlab_repositories(gitlab_username)

if __name__ == "__main__":
    main()
