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
                  // sh 'docker tag capstone-project babyd/capstone'
                  // sh 'docker push babyd/capstone'
                  }
                 
                  // script {
                  //     docker.withRegistry('', docker){
                  //     dockerImage.push()
                  //   }
                  }

              }

                 
              }
        //  }
         stage('Deploy Container') {
              steps {
                  withAWS(region:'us-west-2',credentials:'myCredentials') {
                  sh 'echo "Uploading content with AWS creds"'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'babyd-static-jenkins-pipeline')
                  // sh "aws eks --region us-west-2 update-kubeconfig --name capstone-linux"
                  // sh "eksctl create cluster --name capstones --version 1.17 --nodegroup-name linux --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed"
                  sh "aws eks --region us-west-2 update-kubeconfig --name capstone"
                  sh "kubectl config use-context arn:aws:eks:us-west-2:088693160200:cluster/capstone"
                  // sh "kubectl create deployment capstone --image=babyd/capstone:v1"
                  // sh "kubectl run capstone --image=babyd/capstone"
                  sh "kubectl set image deployments/capstone capstone=babyd/capstone"
                  sh "kubectl apply -f Services/capstone-deployment.yml"
                  sh "kubectl get nodes"
                  sh "kubectl get pod -o wide"
                  sh "kubectl get deployment"
                  sh "kubectl get service/capstone"
                  }
              }
         }

        stage("Cleaning up") {
              steps{
                    echo 'Cleaning up...'
                    sh "docker system prune"
              }
        }
        //  }         
     }
}
