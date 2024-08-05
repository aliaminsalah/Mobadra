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
                    // Install docker-compose
                    sh 'curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
                    sh 'chmod +x /usr/local/bin/docker-compose'
                    sh 'ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('petclinic-image:latest')
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    docker.image('petclinic-image:latest').inside {
                        sh 'docker-compose -f docker-compose.yml up --abort-on-container-exit'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()  // Clean workspace after the build
        }
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
