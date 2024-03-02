pipeline {
    agent any

    environment {
        dockerImage =''
        registry = 'makbar4721/dicea3:latest' 
        registryCredential = 'dockerhub_id'
    }


    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker-compose build"
                }
            }
        }

        stage('Tag and Push Docker Image') {
            steps {
                script {
                    sh "docker tag server $registry"
                    
                    withCredentials([usernamePassword(credentialsId: registryCredential, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                        sh "docker push $registry"
                    }
                }
            }
        }

        stage('Pull and Deploy New Image') {
            steps {
                script {
                    sh "docker-compose pull"

                    sh "docker-compose up -d"
                }
            }
        }
    }

    post {
        success {
            echo "CD process completed successfully!"
        }
        failure {
            echo "CD process failed! Please check the logs for details."
        }
    }
}
