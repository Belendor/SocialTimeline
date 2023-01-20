pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }
    
    stages {
        stage('Hello') {
            steps {
                sh '''
                    docker --version
                    docker compose version
                '''
            }
        }
    }
}