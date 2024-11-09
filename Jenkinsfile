pipeline {
    agent any
       stages{
           stage('Git Checkout'){
               steps{
                   git branch: 'OussamaKoussaier', url: 'https://github.com/oussamakoussaier/Project-DevOps.git'
               }
           }
           stage('UNIT Testing'){
               steps{
                   sh "mvn -version"
               }
           }
           stage('Integration Testing'){
               steps{
                   sh "mysql -h 192.168.33.10 -P 3306 -u root -p"
                   sh "mvn verify -DskipUnitTests"
               }
           }
           
       }
}
