pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials' // Docker Hub credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/aliaminsalah/Mobadra.git'
            }
        }

        stage('Install Docker Compose') {
            steps {
                script {
                    // Install docker-compose with sudo
                    sh '''
                        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /tmp/docker-compose
                        sudo mv /tmp/docker-compose /usr/local/bin/docker-compose
                        sudo chmod +x /usr/local/bin/docker-compose
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('petclinic-image:latest')
                }
            
