pipeline {
    agent { label 'slave-2' }  // Runs on any available agent
    stages {
        stage('Clone Repository') {
            steps {
                // Checkout the Terraform code from Git repository
                git branch: 'main', url: 'https://github.com/your-repo/terraform-configs.git'  // Replace with your repository
            }
        }
        stage('Initialize Terraform') {
            steps {
                script {
                    // Initialize Terraform (this installs providers, etc.)
                    sh 'terraform init'
                }
            }
        }
        stage('Validate Terraform') {
            steps {
                script {
                    // Validate the Terraform files for syntax and errors
                    sh 'terraform validate'
                }
            }
        }
        stage('Plan Terraform') {
            steps {
                script {
                    // Terraform Plan to check what changes will be made
                    sh 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Apply Terraform') {
            steps {
                script {
                    // Apply the Terraform configuration to provision resources
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
