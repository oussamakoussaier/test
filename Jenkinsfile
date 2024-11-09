pipeline {
    agent any
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'OussamaKoussaier', url: 'https://github.com/oussamakoussaier/Project-DevOps.git'
            }
        }
        stage('Wait for MySQL') {
            steps {
                script {
                    // Wait for MySQL to be available
                    sh '''
                        until nc -zv mysql 3306; do
                          echo "Waiting for MySQL to be ready..."
                          sleep 5
                        done
                        echo "MySQL is up and running!"
                    '''
                }
            }
        }
        stage('Unit Testing') {
            steps {
                sh "mvn -version"
            }
        }
        stage('Integration Testing') {
            steps {
                sh "mvn verify -DskipUnitTests"
            }
        }
    }
}
