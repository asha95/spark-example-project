node {
    stage('SCM Checkout'){
    git 'https://github.com/soulmachine/spark-example-project.git'
    }

     stage('SBT build'){
        sh 'sbt clean package'
    }
    
    	stage(' UPLOAD artifacts and inputfile to  S3'){
    
         withAWS(region:'us-east-1',credentials:'s3_credentials'){
         
         sh "aws s3 mb s3://pocemr$BUILD_NUMBER --region us-east-1"
         
         sh "aws s3api put-bucket-versioning --bucket pocemr$BUILD_NUMBER --versioning-configuration Status=Enabled"
         
         //sh "aws s3api put-object --bucket pocemr$BUILD_NUMBER --key jar"
         
          //sh "aws s3api put-object --bucket pocemr$BUILD_NUMBER --key input"
          
         sh "aws s3 cp /var/lib/jenkins/workspace/EMR/target/scala-2.11/ s3://pocemr$BUILD_NUMBER/jar/ --recursive --exclude 'classes/*'"
       
         sh "aws s3 cp /var/lib/jenkins/workspace/EMR/inputfile/   s3://pocemr$BUILD_NUMBER/input/ --recursive"
       
         sh "aws s3 rm s3://pocemr$BUILD_NUMBER/output --recursive"
      }
       
       
      
   }
       

}


