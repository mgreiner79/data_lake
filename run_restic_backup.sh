export AWS_ACCESS_KEY_ID=4HEE5MDAJT0081VJC7IQ
export AWS_SECRET_ACCESS_KEY=5rGwW3Lfz3lBVd4RUyKBAFkY5UwZJZZkMQ6elwex

#./bin/restic.exe -r restic_backup init
./bin/restic.exe -r restic_backup backup s3:http://localhost:9000/testbucket
