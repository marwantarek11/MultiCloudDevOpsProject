@Library('shared-library')_
pipeline {
    agent any

    environment {
        dockerHubCredentialsID = 'DockerHub'
        imageName = 'marwantarek11/ivolve-app'
        openshiftCredentialsID = 'openshift'
        nameSpace = 'marwantarek'
        clusterUrl = 'https://api.ocp-training.ivolve-test.com:6443'
        sonarqubeUrl                = 'http://44.204.73.101:9000/'
        sonarTokenCredentialsID     = 'sonarqube'
    }

    stages {
        stage('Repo Checkout') {
            steps {
            	script {
                	checkRepo()
                }
            }
        }
        stage('Running Test') {
            steps {
                script {
                        dir('Application') {
                    runUnitTests() 
                }
            }
        }
    }
        stage('Build App') {
            steps {
                script {
                        dir('Application') {
                    build()
                }
            }
        }
    }        
        
        stage('Sonarqube Analysis') {
            steps {
                script {
                        dir('Application') {
                    runSonarQubeAnalysis()
                    }
                }
            }
        }   
        stage('Build & Push Docker Image') {
            steps {
                script {
                        dir('Application') {
                    buildandPushDockerImage(dockerHubCredentialsID, imageName)
            }
        }
    }
}
        stage('editDeploymentYaml') {
            steps {
                script {
                        dir('openshift') {
                   editDeploymentYaml(imageName)
                }
            }
        }
    }
               
        stage('deployOnOc') {
            steps {
                script {
                        dir('openshift') {
                   deployOnOpenshift(openshiftCredentialsID, nameSpace, clusterUrl)
                }
            }
        }
    }
}
    post {
        success {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline succeeded"
        }
        failure {
            echo "${JOB_NAME}-${BUILD_NUMBER} pipeline failed"
        }
    }         
}
