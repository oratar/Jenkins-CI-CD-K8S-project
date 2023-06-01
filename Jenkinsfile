pipeline {
  agent {
    kubernetes {
      yamlFile 'manifests/builder.yaml' 
    }
  }
  environment {
    DOCKERHUB = credentials('dockerhub_cred')
    DOCKERHUB_REGISTERY = 'oratar333/dotnet_app'
    MAJ ='1'
    IMG_TAG = "$MAJ.${BUILD_NUMBER}"
  }
  stages {
    stage('build') {
      steps {
         container('dind') {
                sh ' docker build -t dotnet_app .'
        }
      } 
    }
    stage('push') {
      steps {
         container('dind') {
           script {
             sh '''
                  echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                  docker image tag dotnet_app $DOCKERHUB_REGISTERY:$IMG_TAG
           }
          
         }
        }
      }  
  } 
  
}
