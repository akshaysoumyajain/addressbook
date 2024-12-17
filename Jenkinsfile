pipeline {
    agent none
    tools {
        jdk 'myjava'
        maven 'mymaven'
    }
    parameters {
        string(name: 'Env', defaultValue: 'Test', description: 'version to deploy')
        booleanParam(name: 'executeTests', defaultValue: true, description: 'decide to execute tc')
        choice(name: 'APPVERSION', choices:['1.1', '1.2', '1.3'])
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                echo 'Compiling the code'
                echo "Compiling in ${params.Env}"
                sh 'mvn compile'
            }
        }
        stage('Unittest') {
            agent any
            when {
                expression {
                    params.executeTests == true
                }
            }
            steps {
                echo 'Testing the code'
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent {
                label 'linux_slave1'
            }
            input {
                message "Select the version to package"
                ok "Version selected"
                parameters {
                    choice(name: 'NEWAPP', choices:['1.2', '2.1', '3.1'])
                }
            }
            steps {
                echo 'Packaging the code'
                echo "Packaging version ${params.APPVERSION}"
                sh 'mvn package'
            }
        }
    }
}
