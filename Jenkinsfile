pipeline {
     environment{
         dockerpath = "babyd/capstone"
         dockerImage = ''
         docker =  'dockerhubCredentials'
     }

     agent any
     stages {
         stage('Build') {
             steps {
                 sh 'echo Building Capstone Project'
                 sh '''
                     echo "Final Cloud Devops Project"
                     ls -lah
                 '''
             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build Docker image') {
              steps {
                  sh 'dockerImage = docker.build dockerpath + ":$BUILD_NUMBER"'
                //   sh 'docker build . --tag=capstone-project'
              }
         }
       
        //  stage('Push Docker image') {
        //       steps { 
        //          aquaMicroscanner imageName: 'alpine', notCompliesCmd: '', onDisallowed: 'ignore', outputFormat: 'html'
        //       }
         stage('Push Docker Image') {
            //   steps {
            //       withDockerRegistry([url:'',credentialsId:'dockerhubCredentials']) {
                
            //       sh 'docker push babyd/capstone:capstone-project'    
            //   }

                  sh 'docker.withREgistry('', docker){
                      dockerImage.push
                  }'
              }
         }
         stage('Deploy Container') {
              steps {
                  withAWS(region:'us-west-2',credentials:'myCredentials') {
                  sh 'echo "Uploading content with AWS creds"'
                      s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'babyd-static-jenkins-pipeline')
                  }
              }
         }
        //  }         
     }
}
