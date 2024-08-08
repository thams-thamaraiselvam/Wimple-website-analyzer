#!/bin/bash

# Check if a website URL is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a website URL as an argument"
    exit 1
fi

url="$1"  # Get the website URL from the command-line argument

# Send a GET request and analyze the headers
response=$(curl -sI $url)

# Extract and display the server and language information from the headers
server=$(echo "$response" | grep "Server:")
language=$(echo "$response" | grep "X-Powered-By:")

echo "Web server: $server"
echo "Programming language: $language"
