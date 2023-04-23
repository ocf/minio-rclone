rclone config update o3 access_key_id="$O3_ACCESS_KEY" secret_access_key="$O3_SECRET_KEY"
rclone config update minio access_key_id="$MINIO_ROOT_USER" secret_access_key="$MINIO_ROOT_PASSWORD"

# Minio will be using MINIO_ROOT_USER and MINIO_ROOT_PASSWORD as access key and secret access key
minio server /data --console-address ":9001" &

minio_pid=$!

# Wait for Minio to be started
while ! curl -s -o /dev/null http://localhost:9001
do
	sleep 1
done

# Increase retry count because appeared to have fails transfering large (>= 5GB) files
rclone sync --low-level-retries=5  --retries=4 -M o3:backup-test minio:backup-testkill $minio_pid