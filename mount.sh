cat > /etc/systemd/system/daylight.service <<EOF
[Unit]
Description=Rclone
AssertPathIsDirectory=/mnt/googledrive
After=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/rclone mount DayLight: /mnt/googledrive  \
--use-mmap --umask 000 --default-permissions \
--no-check-certificate --allow-other --allow-non-empty \
--vfs-cache-mode full \
--buffer-size 256M --vfs-read-ahead 512M --vfs-read-chunk-size 32M \
--vfs-read-chunk-size-limit off --vfs-cache-max-size 10G \
--low-level-retries 200
ExecStop=/bin/fusermount -qzu /mnt/googledrive
Restart=on-abort
User=root


[Install]
WantedBy=default.target
EOF