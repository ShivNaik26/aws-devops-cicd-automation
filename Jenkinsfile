pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Build stage started'
            }
        }

        stage('Test') {
            steps {
                echo 'Test stage started'
            }
        }

        stage('SonarQube') {
            steps {
                echo 'SonarQube stage will be configured next'
            }
        }

        stage('Dependency Check') {
            steps {
                echo 'OWASP Dependency-Check stage will be configured next'
            }
        }
    }
}
