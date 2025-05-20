pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/Nayra000/PipelineCraft.git'
        BRANCH = 'main'
        IMAGE_NAME = 'nayra000/simple_nodeapp'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Repository') {
            steps {
                git url: "${REPO_URL}", branch: "${BRANCH}"
            }
        }

        stage('Install Dependencies') {
            steps {
                dir('nodejs_project') {
                    script {
                        sh "npm install"
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                dir('nodejs_project') {
                    script {
                        sh "npm test"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('nodejs_project') {
                    script {
                        sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                    }
                }
            }
        }

        stage('login-dockerhub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker_credentials', usernameVariable: 'DOCKERHUB_CREDENTIALS_USR', passwordVariable: 'DOCKERHUB_CREDENTIALS_PSW')]) {
                        sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            slackSend channel: 'pipeline_craft', message: "✅ Build Succeeded! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}, Time: ${new Date()}"
        }
        failure {
            slackSend channel: 'pipeline_craft', message: "❌ Build Failed! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}, Time: ${new Date()}"
        }
    }
}
