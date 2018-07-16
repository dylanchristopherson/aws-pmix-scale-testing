#!/bin/bash


source /var/lib/jenkins/aws-pmix-scale-testing/buckets.sh


path_to_file=""
counter=0

#Gets number of clusters up by checking the length of the list
lines=$(cfncluster list | less | wc -l)

while [ $lines -gt $counter ]
do

    path_to_file="s3://$logs/${1}-${counter}_output.tar.gz"

    exists=$(aws s3 ls $path_to_file)
   
    if [ -z "$exists" ]; then
        echo "${path_to_file} doesn't exist yet"
        sleep 2m
    else
        echo "${path_to_file} exists"
        echo "Copying to /var/lib/jenkins/workspace/AWS.launch.test/"

        aws s3 cp s3://$logs/${1}-${counter}_output.tar.gz /var/lib/jenkins/workspace/AWS.launch.test/
        ((counter++))
        
    fi
done

