@Library('shared-library')_
pipeline {
    agent any

    environment {
        dockerHubCredentialsID = 'DockerHub'
        imageName = 'marwantarek11/java-app'
        openshiftCredentialsID = 'openshift'
        nameSpace = 'marwantarek'
        clusterUrl = 'https://api.ocp-training.ivolve-test.com:6443'
        sonarqubeUrl                = 'http://54.158.188.190:9000/'
        sonarTokenCredentialsID     = 'sonarqube'
    }

    stages {
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
                    Build()
                }
            }
        }
    }

        stage('Sonarqube Analysis') {
            steps {
                script {
                        dir('Application') {
                    Sonarqube()
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
        stage('editNewImage') {
            steps {
                script {
                        dir('openshift') {
                    editNewImage(imageName)
                }
            }
        }
}
        stage('deployOnOc') {
            steps {
                script {
                        dir('openshift') {
                    deployOnOc(openshiftCredentialsID, nameSpace, clusterUrl)
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
