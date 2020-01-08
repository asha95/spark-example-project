node {
    stage('git checkout'){
    git 'https://github.com/soulmachine/spark-example-project.git'
    }

     stage('sbt build'){
        sh 'sbt clean package'
    }
    
    	stage(' UPLOAD artifacts and inputfile to  S3'){
    
      withAWS(region:'us-east-1',credentials:'s3_credentials'){
          
         sh "aws s3 cp /var/lib/jenkins/workspace/EMR/target/scala-2.11/ s3://pocemr1/jar/ --recursive --exclude 'classes/*'"
       
         sh "aws s3 cp /var/lib/jenkins/workspace/EMR/inputfile/   s3://pocemr1/input/ --recursive"
       }
      
   }
    stage('emr cluster creation'){
        sh "aws emr create-cluster --applications Name=Hadoop Name=Spark --tags 'Name=POC' --ec2-attributes '{"KeyName":"dockerdemo","InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-00b8a04a","EmrManagedSlaveSecurityGroup":"sg-0ac14af1cfb0d2eef","EmrManagedMasterSecurityGroup":"sg-0bc230bdfc210fa36"}' --release-label emr-5.16.0 --log-uri 's3n://emr-logs123/logs/' --steps '[{"Args":["spark-submit","--deploy-mode","client","--class","me.soulmachine.spark.WordCount","s3://pocemr1/jar/spark-example-project_2.11-1.0.0-SNAPSHOT.jar","s3://pocemr1/input/wordcount/metamorphosis.txt","s3://pocemr1/output/"],"Type":"CUSTOM_JAR","ActionOnFailure":"CONTINUE","Jar":"command-runner.jar","Properties":"","Name":"Spark application"},{"Args":["spark-submit","--deploy-mode","client","--class","me.soulmachine.spark.WordCount","s3://pocemr1/jar/spark-example-project_2.11-1.0.0-SNAPSHOT.jar","s3://pocemr1/input/wordcount/metamorphosis.txt","s3://pocemr1/output/wordcount"],"Type":"CUSTOM_JAR","ActionOnFailure":"CONTINUE","Jar":"command-runner.jar","Properties":"","Name":"Spark application"},{"Args":["spark-submit","--deploy-mode","client","--class","me.soulmachine.spark.WordCount","s3://pocemr1/jar/spark-example-project_2.11-1.0.0-SNAPSHOT.jar","s3://pocemr1/input/wordcount/metamorphosis.txt","s3://pocemr1/output/wordcount"],"Type":"CUSTOM_JAR","ActionOnFailure":"CONTINUE","Jar":"command-runner.jar","Properties":"","Name":"Spark application"}]' --instance-groups '[{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":1}]},"InstanceGroupType":"CORE","InstanceType":"m5.xlarge","Name":"Core - 2"},{"InstanceCount":1,"EbsConfiguration":{"EbsBlockDeviceConfigs":[{"VolumeSpecification":{"SizeInGB":32,"VolumeType":"gp2"},"VolumesPerInstance":1}]},"InstanceGroupType":"MASTER","InstanceType":"m5.xlarge","Name":"Master - 1"}]' --auto-scaling-role EMR_AutoScaling_DefaultRole --ebs-root-volume-size 10 --service-role EMR_DefaultRole --enable-debugging --name 'poc-advance' --scale-down-behavior TERMINATE_AT_TASK_COMPLETION --region us-east-1"
}
}

