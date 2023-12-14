pipeline {
    agent any
    tools {
        maven 'MAVEN'
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'echo passed'
                git branch: 'main', url: 'https://github.com/svenkatesh9666/vprofile.java.git'
            }
        }

        stage('Build') {
            steps {
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

        stage('Static Code Analysis') {
            environment {
                SONAR_URL = "http://54.87.107.224:9000"
            }
            steps {
                withCredentials([string(credentialsId: 'sonar', variable: 'SONAR')]) {
                  sh "mvn clean verify sonar:sonar -Dsonar.projectKey=vprofile-project -Dsonar.host.url=${SONAR_URL} -Dsonar.login=${sonar}"
                }
            }
        }
        stage('upload war to nexus'){
            steps{
                
                nexusArtifactUploader artifacts: [
                    [
                    artifactId: 'vprofile', 
                    classifier: '', 
                    file: 'target/vprofile-v2.war', 
                    type: 'war']
                    ], 
                    credentialsId: 'nexus', 
                    groupId: 'com.visualpathit', 
                    nexusUrl: '3.86.50.51:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'vprofile_releases', 
                    version: 'v2'
                
            }
        }
       stage('build docker image'){
            steps{
                script{
                sh "docker image build -t $JOB_NAME:v2.$BUILD_ID ."
                sh "docker image tag $JOB_NAME:v2.$BUILD_ID 123dockerpractice/$JOB_NAME:v2.$BUILD_ID"
                sh "docker image tag $JOB_NAME:v2.$BUILD_ID 123dockerpractice/$JOB_NAME:latest"
                }

            }
        }
        stage('push image to dockerhub'){
            steps{
                script{
                  withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'passwd_cred', usernameVariable: 'user_cred')]) {

                      sh 'docker login -u ${user_cred} -p ${passwd_cred}'
                      sh 'docker push 123dockerpractice/$JOB_NAME:latest'
                      sh 'docker run -d -p 9090:8080 --name myjavacontainer 123dockerpractice/$JOB_NAME'

                  }
                }
            }
        }
    }
}
