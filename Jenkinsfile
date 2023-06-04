pipeline {
  agent {
    kubernetes {
      yamlFile 'manifests/jenkins/builder.yaml' 
    }
  }
  environment {
    DOCKERHUB = credentials('dockerhub_cred')
    DOCKERHUB_REGISTRY = 'oratar333/dotnet_app'
    MAJ = '1'
    IMG_TAG = "$MAJ.${BUILD_NUMBER}"
  }
  stages {
    stage('build') {
      steps {
        container('dind') {
          sh 'docker build -t dotnet_app .'
        }
      } 
    }
    stage('push') {
      steps {
        container('dind') {
          script {
            sh '''
              echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
              docker image tag dotnet_app $DOCKERHUB_REGISTRY:$IMG_TAG
              docker push $DOCKERHUB_REGISTRY:$IMG_TAG
            '''
          }
        }
      }
    }
    stage('deploy') {
      steps {
        container('kubectl') {
          withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
            script {
              sh '''               
               sed -i "s/<TAG>/$IMG_TAG /" ./manifests/application/app-pod.yaml
               kubectl apply -f ./manifests/application/app-pod.yaml
               kubectl apply -f ./manifests/application/service.yaml
              '''
            }
          }
        }
      }
    }
  } 
}

