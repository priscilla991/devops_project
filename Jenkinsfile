pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/priscil/devops_project.git'
            }
        }

        stage('Test') {
            steps {
                sh 'chmod +x script.sh test.sh'
                sh './test.sh'
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t hello-devops:latest .'
            }
        }

        stage('Run Docker container') {
            steps {
                sh 'docker run --rm hello-devops:latest'
            }
        }
    }
}
