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
}

