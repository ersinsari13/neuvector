pipeline {
    agent any
    environment {
        APP_NAME="neuvector"
        APP_REPO_NAME="ersin-repo/${APP_NAME}"
        AWS_REGION="us-east-1"
        AWS_ACCOUNT_ID=sh(script:'aws sts get-caller-identity --query Account --output text',returnStdout:true).trim()
        ECR_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }
    stages {
        stage('Log in to ECR') {
            steps {
                echo "logging to ECR "
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 995194808144.dkr.ecr.us-east-1.amazonaws.com'
                }
        }
        stage('Build App Docker Images') {
            steps {
                echo 'Building App Dev Images'
                sh "docker build --force-rm -t '${ECR_REGISTRY}/${APP_REPO_NAME}:${BUILD_NUMBER}' ."
                sh 'docker image ls'
            }
        }

        stage('Push Images to ECR') {
            steps {
                echo "Pushing ${APP_NAME} App Images to ECR Repo"
                sh "docker push '${ECR_REGISTRY}/${APP_REPO_NAME}:${BUILD_NUMBER}'"
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
                repository: "995194808144.dkr.ecr.us-east-1.amazonaws.com/flask-app", 
                scanLayers: true, 
                tag: "latest"
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