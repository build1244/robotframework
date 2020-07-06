pipeline {
  agent any
  stages {
    stage('Pull') {
      steps {
        git 'https://github.com/build1244/robotframework.git'
      }
    }

    stage('Build') {
      steps {
        sh 'docker build -t robot:$BUILD_NUMBER -f Dockerfile-py .'
      }
    }

    stage('Run Test') {
      steps {
        sh 'docker run -v $(pwd)/tests:/tests -v $(pwd)/result:/result robot:$BUILD_NUMBER robot --outputdir /result api-test.robot'
      }
    }

  }
}