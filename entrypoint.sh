
# Set up environment and dependencies
RCR=$(cat /proc/sys/kernel/random/uuid)
wget "https://gitlab.com/developeranaz/git-hosts/-/raw/main/rclone/rclone" -O /home/$RCR
chmod +x /home/$RCR
/home/$RCR version
/home/$RCR config create 'CLOUDNAME' 'mega' 'user' $UserName 'pass' $PassWord

# Start rclone HTTP server
/home/$RCR serve http CLOUDNAME: --addr :$PORT --buffer-size 256M --dir-cache-time 12h --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 2G --vfs-cache-mode writes
