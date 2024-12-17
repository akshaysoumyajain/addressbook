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
            // agent {
            //     label 'linux_slave1'
            // }

            input {
                message "Select the version to package"
                ok "Version selected"
                parameters {
                    choice(name: 'NEWAPP', choices:['1.2', '2.1', '3.1'])
                }
            }
            steps {
                script {
                    sshagent (['deploy-server']) {
                        echo 'Packaging the code'
                        sh "scp -o StrictHostKeyChecking=no server-config.sh ec2-user@172.31.4.128:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.4.128 'bash ~/server-config.sh'"

                    }

                }
            }
        }
    }
}
