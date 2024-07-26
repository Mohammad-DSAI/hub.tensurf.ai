#!/bin/bash

# Change to the specified directory

# Get the remote repository URL
remote_url=$(git remote get-url origin)

# Print the current remote origin URL
echo "Current origin URL: $remote_url"

# Extract the username and repository name from the URL
if [[ $remote_url =~ git@github\.com:(.+)/(.+)\.git ]]; then
    username=${BASH_REMATCH[1]}
    repository=${BASH_REMATCH[2]}
    echo "Username: $username"
    echo "Repository: $repository"

    # Construct the HTTPS URL for checking
    https_url="https://github.com/$username/$repository"
    
    # Check if the repository exists by sending a request and checking the status code
    status_code=$(curl -o /dev/null -s -w "%{http_code}" "$https_url")

    if [ "$status_code" -eq 200 ]; then
        echo "The repository exists: $https_url"
    else
        echo "The repository does not exist or is private."
    fi
else
    echo "Not a valid GitHub repository URL."
fi

