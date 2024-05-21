# Set up environment and dependencies
RCR=$(cat /proc/sys/kernel/random/uuid)

wget "https://gitlab.com/developeranaz/git-hosts/-/raw/main/rclone/rclone" -O /home/$RCR

chmod +x /home/$RCR

/home/$RCR version

# Prompt user for PIN
echo "Enter a PIN to HTTP:"
read -s PIN

# Start rclone HTTP server with credentials from environment variables and user-provided PIN
/home/$RCR config create 'CLOUDNAME' 'mega' 'user' "$MEGA_USERNAME" 'pass' "$MEGA_PASSWORD"

/home/$RCR serve http CLOUDNAME: --addr :$PORT --buffer-size 256M --dir-cache-time 12h --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 2G --vfs-cache-mode writes --pin-code $PIN
