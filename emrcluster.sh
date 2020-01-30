#!/bin/bash
aws emr create-cluster \
    --release-label emr-5.14.0 \
	--applications Name=Hadoop Name=Spark \
	--ec2-attributes KeyName=k8s \
    --instance-type m4.large \
    --instance-count 2 --use-default-roles --log-uri s3://pocemr76
