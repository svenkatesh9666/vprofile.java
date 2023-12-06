pipeline {
  agent any
stages {
  stage('git checkout'){
    steps{
git branch: 'main', url: 'https://github.com/svenkatesh9666/vprofile.java.git'
}
}
  stage('maven build'){
    steps{
      sh 'mvn clean package'
    }
  }
}
}
