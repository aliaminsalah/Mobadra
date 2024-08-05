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

        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${env.DOCKER_CREDENTIALS_ID}") {
                        docker.image('petclinic-image:latest').push('latest')
                    }
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    sh 'docker-compose down'
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
