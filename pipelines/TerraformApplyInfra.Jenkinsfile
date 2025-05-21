pipeline {
    agent any

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Nayra000/PipelineCraft.git', branch: 'main'
            }
        }

        stage('Initialize Terraform') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws_credentials',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir('cloud-infra') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Plan Infrastructure') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws_credentials',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir('cloud-infra') {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Apply Changes') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws_credentials',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir('cloud-infra') {
                        sh 'terraform apply -auto-approve tfplan'
                    }
                }
            }
        }
    }

    post {
        success {
            slackSend channel: 'pipeline_craft', message: "✅ Terraform Apply Succeeded! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}, Time: ${new Date()}"
        }
        failure {
            slackSend channel: 'pipeline_craft', message: "❌ Terraform Apply Failed! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}, Time: ${new Date()}"
        }
    }
}
