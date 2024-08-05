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
