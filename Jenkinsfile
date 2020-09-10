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
                //   sh 'dockerImage = docker.build dockerpath + ":$BUILD_NUMBER"'
                  sh 'echo building docker image'
                  sh 'docker build . --tag=capstone-project'
                //   script{
                //       dockerImage = docker.build dockerpath + ":$BUILD_NUMBER"
                //   }
              }
         }
       
        //  stage('Push Docker image') {
        //       steps { 
        //          aquaMicroscanner imageName: 'alpine', notCompliesCmd: '', onDisallowed: 'ignore', outputFormat: 'html'
        //       }
         stage('Push Docker Image') {
              steps {
                  withDockerRegistry([url:'',credentialsId:'dockerhubCredentials']) {
                  sh 'echo "Uploading docker image"'
                  sh 'docker tag capstone-project babyd/capstone'
                  sh 'docker push babyd/capstone'
                  }
                 
                //   script {
                //       docker.withRegistry('', docker){
                //       dockerImage.push()
                //     }
                //   }

              }

                 
              }
        //  }
         stage('Deploy Container') {
              steps {
                  withAWS(region:'us-west-2',credentials:'myCredentials') {
                  sh 'echo "Uploading content with AWS creds"'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'babyd-static-jenkins-pipeline')
                  sh "aws eks --region us-west-2 update-kubeconfig --name capstone-linux-nodes-Node"
                  }
              }
         }
        //  }         
     }
}
