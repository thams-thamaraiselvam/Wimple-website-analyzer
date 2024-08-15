#!/bin/bash

# Check if a website URL is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a website URL as an argument"
    exit 1
fi

url="$1"

# Extract the domain name from the URL (removing "http://", "https://", "www.", etc.)
domain=$(echo "$url" | sed -e 's#^https\?://##' -e 's#^www\.##' -e 's#/.*##')

# Send a GET request and analyze the headers
response=$(curl -sI $url)

# Extract the server name and version
server_info=$(echo "$response" | grep -i "Server:" | cut -d' ' -f2-)

# Extract the programming language/framework info
language=$(echo "$response" | grep -i "X-Powered-By:" | cut -d' ' -f2-)

# Extract the HTTP version
http_version=$(echo "$response" | head -n 1 | cut -d' ' -f1)

# Check if SSL/TLS is enabled by attempting an HTTPS request
ssl_check=$(curl -sI https://$url > /dev/null && echo "Enabled" || echo "Not enabled")

# Get the website IP address
ip_address=$(dig +short "$domain" | head -n 1)

# Display the results
echo "Web server: ${server_info:-'Not found'}"
echo "Programming language/Technology: ${language:-'Not found'}"
echo "HTTP version: ${http_version:-'Not found'}"
echo "SSL/TLS: $ssl_check"
echo "IP address: ${ip_address:-'Not found'}"



########  To Run: ./analyze_website.sh https://www.your_websit_name.com #######
