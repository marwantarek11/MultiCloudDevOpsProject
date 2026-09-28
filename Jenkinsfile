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
        // Includes up to 30 min waiting in 'Approve Deploy'
        timeout(time: 75, unit: 'MINUTES')
    }

    environment {
        imageName          = 'ivolve-app'
        pushRegistry       = 'docker-registry.docker-registry.svc:5000'   // Kaniko pushes via the in-cluster service
        pullRegistry       = 'localhost:30500'                            // kubelet pulls via the registry NodePort
        nameSpace          = 'ivolve'
        appUrl             = 'http://ivolve-app-service.ivolve.svc:8080/'
        sonarServer        = 'sonarqube'
        trivyServer        = 'http://trivy.trivy.svc:4954'
        trivyCredentialsID = 'trivy-token'
    }

    stages {
        stage('Running Test') {
            steps {
                script {
                    dir('Application') {
                        runUnitTests()   // also writes the JaCoCo coverage report (test finalizedBy jacocoTestReport)
                    }
                }
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'Application/build/test-results/test/*.xml'
                    publishHTML(target: [reportName: 'Coverage Report', reportDir: 'Application/build/reports/jacoco/test/html',
                                         reportFiles: 'index.html', keepAll: true, alwaysLinkToLastBuild: true, allowMissing: true])
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

        stage('Code Analysis') {
            parallel {
                stage('Sonarqube Analysis') {
                    steps {
                        script {
                            dir('Application') {
                                runSonarQubeAnalysis(sonarServer)
                            }
                        }
                    }
                }

                stage('Dependency & Secret Scan') {
                    steps {
                        script {
                            // Libraries bundled in the built jar + secrets in the sources, before spending time on the image.
                            // Report only for now, like the image scan: set failBuild: true to block on HIGH/CRITICAL findings
                            trivyScan(type: 'rootfs',
                                      target: 'Application',
                                      scanners: 'vuln,secret',
                                      id: 'trivy-deps',
                                      name: 'Dependency Scan',
                                      server: trivyServer,
                                      credentialsId: trivyCredentialsID,
                                      severity: 'HIGH,CRITICAL',
                                      failBuild: false)
                        }
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

        stage('Approve Deploy') {
            steps {
                // Build pod stays up while waiting; no answer within 30 min aborts the build
                timeout(time: 30, unit: 'MINUTES') {
                    input message: "Deploy ${imageName}:${BUILD_NUMBER} to ${nameSpace}?", ok: 'Deploy'
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
            post {
                failure {
                    rollbackDeployment(nameSpace, imageName)
                }
            }
        }

        stage('Smoke Test') {
            steps {
                smokeTest(url: appUrl)
            }
            post {
                failure {
                    rollbackDeployment(nameSpace, imageName)
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
