node {
    def appDir = '.'  
    def DOCKER_IMAGE = 'my-httpd-server'
    def DOCKER_TAG = 'latest'
    def DOCKER_REGISTRY = 'docker.io'
    def DOCKER_USER = 'sibisam2301'  // Your Docker Hub username
    def DOCKER_CREDENTIALS_ID = 'docker-credentials-id'

    try {
        // Checkout from SCM (Git repository)
        stage('Checkout SCM') {
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'docker-credentials-id', url: 'https://github.com/sibilucky/dockerfile.git']])
        }

        // Build Docker Image
        stage('Build Docker Image') {
            echo 'Building Docker Image...'
            sh """
                docker build -t docker.io/sibisam2301/my-httpd-server:latest .
             """
        }

        // Run Docker Container
        stage('Deploy') {
            echo 'Deploying Docker container...'
            sh """
               docker run -d --name httpd-container -p 7070:80 docker.io/sibisam2301/my-httpd-server:latest
             """
        }

        // Push Docker Image to Docker Registry
        stage('Push to Docker Registry') {
            echo 'Pushing Docker image to registry...'
            withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                sh """
                    echo devika@123 | docker login -u sibisam2301@gmail.com --password-stdin
                    docker push docker.io/sibisam2301/my-httpd-server:latest


                """
            }
        }

    } catch (Exception e) {
        currentBuild.result = 'FAILURE'
        echo "Error: ${e.getMessage()}"
        throw e
    }
}
