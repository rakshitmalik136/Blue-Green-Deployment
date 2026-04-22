#!/bin/bash

# Path to the config file relative to the project root
CONFIG_FILE="./nginx/conf/nginx.conf"

# Identify which server is currently active
if grep -q "server app-blue:80;" "$CONFIG_FILE"; then
    CURRENT="BLUE"
    TARGET="GREEN"
    OLD_LINE="server app-blue:80;"
    NEW_LINE="server app-green:80;"
else
    CURRENT="GREEN"
    TARGET="BLUE"
    OLD_LINE="server app-green:80;"
    NEW_LINE="server app-blue:80;"
fi

echo "---------------------------------------"
echo "Current Active Environment: $CURRENT"
echo "Switching traffic to: $TARGET..."
echo "---------------------------------------"

<<note
Update the config file
Using 'sed' to replace the OLD_LINE with the NEW_LINE
This will safely update the config file without breaking the Docker volume mount
note

sed "s/$OLD_LINE/$NEW_LINE/" "$CONFIG_FILE" > temp.conf
cat temp.conf > "$CONFIG_FILE"
rm temp.conf

# Verify Nginx syntax and Reload
echo "Testing Nginx configuration..."
docker exec nginx-lb nginx -t

if [ $? -eq 0 ]; then
    echo "Syntax OK. Reloading Nginx..."
    docker exec nginx-lb nginx -s reload
    echo "Successfully switched to $TARGET!"
else
    echo "Error: Nginx config test failed. Reverting changes..."
    sed "s/$NEW_LINE/$OLD_LINE/" "$CONFIG_FILE" > temp.conf
    cat temp.conf > "$CONFIG_FILE"
    rm temp.conf
    exit 1
fi
