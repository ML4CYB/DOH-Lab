#!/bin/bash
docker run -it dohtest /bin/bash
container_id=$(docker ps -l --format "{{.ID}}")
cd CSV_files
docker start $container_id

# Replace capturedPackets.csv with the name of the csv file you want to copy
docker cp $container_id:/code/test/capture.csv .
docker stop $container_id