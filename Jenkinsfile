pipeline {
  agent any
  environment { DOCKER_IMAGE = "priscil/hello-devops:latest" }

  stages {
    stage('Checkout') {
      steps { git branch: 'main', url: 'https://github.com/priscilla991/devops_project.git' }
    }
    stage('Test') {
      steps { sh 'chmod +x script.sh test.sh && ./test.sh' }
    }
    stage('Build Docker image') {
      steps { sh 'docker build -t $DOCKER_IMAGE .' }
    }
    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh 'docker push $DOCKER_IMAGE'
        }
      }
    }
    stage('Run Docker container') {
      steps { sh 'docker run --rm $DOCKER_IMAGE' }
    }
  }
}
