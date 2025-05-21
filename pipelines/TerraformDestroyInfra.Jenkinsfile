pipeline {

    agent any

    stages {
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

        stage('Destroy Infrastructure') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws_credentials',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    dir('cloud-infra') {
                        sh 'terraform destroy -auto-approve'
                    }
                }
            }
        }
    }

    post {
        success {
            slackSend channel: 'pipeline_craft', message: "✅ Terraform Destroy Succeeded! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}"
        }
        failure {
            slackSend channel: 'pipeline_craft', message: "❌ Terraform Destroy Failed! Job: ${env.JOB_NAME}, Build: ${env.BUILD_NUMBER}"
        }
    }
}
