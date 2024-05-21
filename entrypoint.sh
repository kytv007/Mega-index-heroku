#!/bin/bash

# Generate a random UUID and use it as part of the file path
RCR=$(cat /proc/sys/kernel/random/uuid)

# Download the rclone binary and save it to /home/$RCR
wget "https://gitlab.com/developeranaz/git-hosts/-/raw/main/rclone/rclone" -O /home/$RCR

# Make the downloaded binary executable
chmod +x /home/$RCR

# Verify the version of rclone
/home/$RCR version

# Prompt user for PIN
echo "Enter a PIN to access rclone over HTTP:"
read -s PIN

# Function to start the rclone server
start_rclone_server() {
  # Create rclone configuration for 'mega' cloud service
  /home/$RCR config create 'CLOUDNAME' 'mega' 'user' "$MEGA_USERNAME" 'pass' "$MEGA_PASSWORD"

  # Start rclone HTTP server with the specified settings
  /home/$RCR serve http CLOUDNAME: --addr :$PORT --buffer-size 256M --dir-cache-time 12h --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 2G --vfs-cache-mode writes
}

# Infinite loop to ask for PIN
while true; do
  echo "Enter the PIN to start rclone server:"
  read -s input_pin

  if [ "$input_pin" == "$PIN" ]; then
    echo "PIN correct. Starting rclone server..."
    start_rclone_server
    break
  else
    echo "Incorrect PIN. Please try again."
  fi
done
