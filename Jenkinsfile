pipeline {
  agent {
    kubernetes {
      yamlFile 'manifests/builder.yaml' 
    }
  }
  stages {
    stage('build') {
      steps {
           container('docker') {
                sh ' docker -h'
        }
      } 
    }
  } 
}
