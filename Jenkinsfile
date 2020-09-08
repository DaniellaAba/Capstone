pipeline {
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
         stage('Build Docker image') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
        //  stage('Push Docker image') {
        //       steps { 
        //          aquaMicroscanner imageName: 'alpine', notCompliesCmd: '', onDisallowed: 'ignore', outputFormat: 'html'
        //       }
        //  }         
         stage('Deploy Container') {
              steps {
                  withAWS(region:'us-west-2',credentials:'myCredentials') {
                  sh 'echo "Uploading content with AWS creds"'
                      s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'babyd-static-jenkins-pipeline')
                  }
              }
         }
     }
}
