pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
    }
    
    stages {
        stage('Checkout') {
            steps {
                script {
                // The below will clone your repo and will be checked out to master branch by default.
                git credentialsId: 'belendor', url: 'https://github.com/Belendor/SocialTimeline.git'
                // Do a ls -lart to view all the files are cloned. It will be clonned. This is just for you to be sure about it.
                sh "ls -lart ./*" 
                // List all branches in your repo. 
                sh "git branch -a"
                // Checkout to a specific branch in your repo.
                sh "git checkout master"
                }
            }
        }
        stage('Test') {
             steps {
                sh '''
                    aws --version
                    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID && \
                    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY && \
                    aws configure set region eu-central-1
                    aws ec2 describe-instances
                '''
            }
        }
    }
}