@Library('shared-library@kubeadm')_  // TODO: back to 'shared-library' after merging the library's kubeadm branch
pipeline {
    // Pod with gradle, kaniko, trivy and kubectl containers (resources/podTemplates/build-pod.yaml in the shared library)
    agent {
        kubernetes {
            yaml libraryResource('podTemplates/build-pod.yaml')
            defaultContainer 'gradle'
        }
    }

    options {
        timestamps()
        timeout(time: 45, unit: 'MINUTES')
    }

    environment {
        imageName          = 'ivolve-app'
        pushRegistry       = 'docker-registry.docker-registry.svc:5000'   // Kaniko pushes via the in-cluster service
        pullRegistry       = 'localhost:30500'                            // kubelet pulls via the registry NodePort
        nameSpace          = 'ivolve'
        sonarServer        = 'sonarqube'
        trivyServer        = 'http://trivy.trivy.svc:4954'
        trivyCredentialsID = 'trivy-token'
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
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'Application/build/test-results/test/*.xml'
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    dir('Application') {
                        build(skipTests: true)   // tests already ran in 'Running Test'
                    }
                }
            }
        }

        stage('Sonarqube Analysis') {
            steps {
                script {
                    dir('Application') {
                        runSonarQubeAnalysis(sonarServer)
                    }
                }
            }
        }

        stage('Build & Push Image') {
            steps {
                script {
                    dir('Application') {
                        buildAndPushImage("${pushRegistry}/${imageName}:${BUILD_NUMBER}")
                    }
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    // Report only for now: set failBuild: true to block on HIGH/CRITICAL findings
                    trivyScan(image: "${pushRegistry}/${imageName}:${BUILD_NUMBER}",
                              server: trivyServer,
                              credentialsId: trivyCredentialsID,
                              severity: 'HIGH,CRITICAL',
                              failBuild: false)
                }
            }
        }

        stage('editDeploymentYaml') {
            steps {
                script {
                    dir('kubernetes') {
                        editDeploymentYaml("${pullRegistry}/${imageName}")
                    }
                }
            }
        }

        stage('Deploy on Kubernetes') {
            steps {
                script {
                    dir('kubernetes') {
                        deployOnKubernetes(nameSpace, imageName)
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
