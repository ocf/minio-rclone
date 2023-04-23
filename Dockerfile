FROM quay.io/minio/minio

# RUN wget https://downloads.rclone.org/v1.62.2/rclone-v1.62.2-linux-amd64.zip | unzip
ADD https://downloads.rclone.org/v1.62.2/rclone-v1.62.2-linux-amd64.rpm /rclone.rpm
RUN rpm -i /rclone.rpm
RUN rm -f /rclone.rpm
ADD rclone.conf /root/.config/rclone/rclone.conf
ADD entry.sh entry.sh

ENTRYPOINT entry.sh