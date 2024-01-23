pipeline {
    agent any
    environment {
        APP_NAME="neuvector"
        APP_REPO_NAME="18.206.242.151:8085"
        AWS_REGION="us-east-1"
    }
    stages {
        stage('Log in to Nexus') {
            steps {
                echo "logging to nexus "
                sh 'docker login -u admin -p Ersin_13 18.206.242.151:8085'
                }
        }
        // stage('Package application') {
        //     steps {
        //         agent {
        //             docker {
        //                 image 'maven:3.9.5-amazoncorretto-17'
        //                 args '-v $HOME/.m2:/root/.m2'
        //                 reuseNode true
        //             }
        //         }
        //         steps {
        //             sh 'mvn clean package'
        //         }
        //     }
        // }
        stage('Prepare Tags for Docker Images') {
            steps {
                echo 'Preparing Tags for Docker Images'
                script {
                    env.IMAGE_TAG="${APP_REPO_NAME}/${APP_NAME}:${BUILD_NUMBER}"
                }
            }
        }
        stage('Build App Docker Images') {
            steps {
                echo 'Building App Dev Images'
                sh "docker build --force-rm -t '${IMAGE_TAG_PETCLINIC}' ."
                sh 'docker image ls'
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
                repository: "${APP_REPO_NAME}/${APP_NAME}", 
                scanLayers: true, 
                tag: "${BUILD_NUMBER}"
      }  
    }
        stage('Push Images to ECR Repo') {
            steps {
                echo "Pushing ${APP_NAME} App Images to ECR Repo"
                sh "docker push '${IMAGE_TAG}'"
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