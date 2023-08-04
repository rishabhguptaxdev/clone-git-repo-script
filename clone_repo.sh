#!/bin/bash

# Check if the repository URL is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: bash clone_repo.sh <repository_url>"
    exit 1
fi

# Get the repository URL from the command-line argument
repo_url="$1"

# Define the destination directory
destination_dir="$HOME/dev"

# Extract the repository name from the URL
repo_name=$(basename "$repo_url" .git)

# Calculate the full path to the destination directory for the repository
repo_path="$destination_dir/$repo_name"

# Check if the repository directory exists
if [ -d "$repo_path" ]; then
    echo "Repository already exists in $repo_path"
else
    # Clone the Git repository into the destination directory
    git clone "$repo_url" "$repo_path"

    # Check if the clone was successful
    if [ $? -eq 0 ]; then
        echo "Repository cloned successfully into $repo_path"
    else
        echo "Error cloning repository"
        exit 1
    fi
fi

# Execute a subshell to change the directory if it exists
if [ -d "$repo_path" ]; then
    (
        cd "$repo_path"
        $SHELL
    )
fi
