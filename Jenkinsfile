pipeline {
    agent {
      label 'docker'
    }

    stages {
        stage('Build') { 
            agent {
              label 'docker'
              image 'node:7-alpine'
	    }
            steps {
                sh 'echo "hello world"'
                sh 'node --version' 
            }
        }
    }
}
