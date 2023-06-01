pipeline {
  agent {
    kubernetes {
      yamlFile 'manifests/builder.yaml' 
    }
  }
  stages {
    stage('build') {
      steps {
           container('dind-daemon') {
                sh ' docker '
        }
      } 
    }
  }
}
