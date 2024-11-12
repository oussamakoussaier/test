pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/oussamakoussaier/test.git'
            }
        }
        stage('Unit Testing') {
            steps {
                sh "mvn test"
            }
        }
        stage('Integration Testing') {
            steps {
                sh "mvn verify -DskipUnitTests"
            }
        }
        stage('Maven Build') {
            steps {
                sh "mvn clean install"
            }
        }
        stage('Static Code Analysis') {
            steps {
                script {
                    
                    withSonarQubeEnv(credentialsId: 'sonar-api-key') {
                        sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage('Quality Gate Status'){
            steps{
               script{
                   waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api-key'
               } 
            }
        }
        stage('Upload War File to Nexus'){
            steps{
                script{
                    //def readPomVersion = readMavenPom file: 'pom.xml'
                    //def nexusRepo = readPomVersion.version.endsWith('SNAPSHOT') ? "demoapp-snapshot" : "demoapp-release"


                    nexusArtifactUploader artifacts: 
                        [
                            [artifactId: 'tp-foyer',
                             classifier: '', 
                             file: 'target/tp-foyer-5.0.0.jar',
                             type: 'jar']
                        ],
                        credentialsId: 'nexus-auth',
                        groupId: 'tn.esprit',
                        nexusUrl: '192.168.33.10:8081',
                        nexusVersion: 'nexus3', 
                        protocol: 'http',
                        repository: 'demoapp-release',
                        version: '1.0'
                }
            }
        }
        stage('Docker Image Build'){
            steps{
                script{
                    sh "docker image build -t $JOB_NAME:v1.$BUILD_ID ."
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID oussama769/$JOB_NAME:v1.$BUILD_ID"
                    sh "docker image tag $JOB_NAME:v1.$BUILD_ID oussama769/$JOB_NAME:latest"
                }
            }
        }
        stage('Push Image To DockerHub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub_cred', variable: 'docker_hub_cred')]) {
                        sh"docker login -u oussama769 -p ${docker_hub_cred}"
                        sh"docker image push oussama769/$JOB_NAME:v1.$BUILD_ID"
                        sh"docker image push oussama769/$JOB_NAME:latest"
                        
                    }
                }
            }
        }

    }
}
