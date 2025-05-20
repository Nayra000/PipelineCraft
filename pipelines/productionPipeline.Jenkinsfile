pipeline {
    agent { label 'slave' }

    environment {
        IMAGE_NAME = 'nayra000/simple_nodeapp'
        IMAGE_TAG = 'latest'
        COMPOSE_FILE_PATH = '/home/ubuntu/jenkins/docker-compose.yaml'
    }

    stages {
        stage('Remove Old Docker Image') {
            steps {
                script {
                    sh """
                        if docker images | grep -q '${IMAGE_NAME}'; then
                            echo "Removing old image ${IMAGE_NAME}:${IMAGE_TAG}"
                            docker rmi -f ${IMAGE_NAME}:${IMAGE_TAG}
                        else
                            echo "No existing image found for ${IMAGE_NAME}"
                        fi
                    """
                }
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    sh "docker pull ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }

        stage('Cleanup Docker Containers') {
            steps {
                script {
                    sh "docker system prune -f"
                }
            }
        }

        stage('Run Docker Compose') {
            steps {
                script {
                    sh "docker-compose -f ${COMPOSE_FILE_PATH} up -d"
                }
            }
        }

        stage('Verify Containers Running') {
            steps {
                script {
                    sh "docker ps --filter 'status=running'"
                }
            }
        }
    }

    post {
        success {
            slackSend channel: 'pipeline_craft', message: "✅ Deploy Succeeded! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}, Time: ${new Date()}"
        }
        failure {
            slackSend channel: 'pipeline_craft', message: "❌ Deploy Failed! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}, Time: ${new Date()}"
        }
    }
}
