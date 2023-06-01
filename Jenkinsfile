pipeline {
  agent {
    kubernetes {
      yamlFile 'manifests/builder.yaml' 
    }
  }
  stages {
    stage('build') {
      steps {
           container('dind') {
                sh ' docker build -t simple_app .'
        }
      } 
    }
  } 
}
