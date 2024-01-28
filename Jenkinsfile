pipeline {
    agent any
    environment {
        APP_REPO_NAME="neuvector"
    }
    stages {
        stage('Log in to Docker') {
            steps {
                echo "logging to ECR "
                sh 'docker login - ersinsari -p Teyyare01** '
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
    //     stage('Deploy App on Kubernetes Cluster'){
    //         steps {
    //             echo 'Deploying App on Kubernetes Cluster'
    //             sh '. ./jenkins/deploy_app_on_prod_environment.sh'
    //         }
    //     }
    // }
    // post {
    //     always {
    //         echo 'Deleting all local images'
    //         sh 'docker image prune -af'
    //     }

    //     success {
    //         mail bcc: '', body: 'Congrats !!! CICD Pipeline is successfull.', cc: '', from: '', replyTo: '', subject: 'Test Mail', to: 'sariiersinn13@gmail.com'
    //         }
    }
}