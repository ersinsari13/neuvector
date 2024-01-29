pipeline {
    agent any
    environment {
        APP_REPO_NAME="neuvector"
    }
    stages {
        stage('Docker Login') {
            steps {
                script {
                    def dockerCredentialsId = 'docker-hub-cred'
                     withCredentials([usernamePassword(credentialsId: dockerCredentialsId, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                       sh """
                            docker login -u \${DOCKER_USERNAME} -p \${DOCKER_PASSWORD}
                        """
                     }    
                }
            }
        }
        stage('Build App Docker Images') {
            steps {
                echo 'Building App Dev Images'
                sh "docker build --force-rm -t ersinsari/neuvector:${BUILD_NUMBER} ."
                sh 'docker image ls'
            }
        }

        stage('Push Images to Docker-Hub') {
            steps {
                echo "Pushing  App Images to Repo"
                sh "docker push 'ersinsari/neuvector:${BUILD_NUMBER}'"
            }
        }

        stage('Image Scan') { 
            steps {
                neuvector nameOfVulnerabilityToExemptFour: '',
                nameOfVulnerabilityToExemptOne: '', 
                nameOfVulnerabilityToExemptThree: '', 
                nameOfVulnerabilityToExemptTwo: '', 
                nameOfVulnerabilityToFailFour: '', 
                nameOfVulnerabilityToFailOne: '', 
                nameOfVulnerabilityToFailThree: '', 
                nameOfVulnerabilityToFailTwo: '', 
                numberOfHighSeverityToFail: '400', 
                numberOfMediumSeverityToFail: '400', 
                registrySelection: 'rmt', 
                repository: "ersinsari/neuvector", 
                scanLayers: true, 
                tag: "${BUILD_NUMBER}"
      }  
    }
    }
}