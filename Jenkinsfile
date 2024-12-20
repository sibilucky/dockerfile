node {
    // Set the working directory for the project
    def appDir = '.'  // Assuming the Dockerfile is in the root of the project
    def DOCKER_IMAGE = 'my-httpd-server'  // Your custom image name
    def DOCKER_TAG = 'latest'
    def DOCKER_REGISTRY = 'docker.io'  // Docker registry (change if necessary)
    def DOCKER_CREDENTIALS_ID = 'docker-credentials-id'  // Jenkins credentials ID
    def GIT_REPO = 'https://github.com/sibilucky/dockerfile.git'

    try {
        // Checkout from SCM (Git repository)
        stage('Checkout SCM') {
            checkout scm(
               branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[
                    credentialsId: DOCKER_CREDENTIALS_ID,  // Use Docker credentials ID here
                    url: 'https://github.com/sibilucky/dockerfile.git'
                ]]
            )
        }

        // Build Docker Image
        stage('Build Docker Image') {
            echo 'Building Docker Image...'
            sh """
                docker build -t docker.io/my-httpd-server:latest .
            """
        }

        // Run Docker Container
        stage('Deploy') {
            echo 'Deploying the project...'
            sh """
                docker run -d --name httpd-container -p 7070:80 docker.io/my-httpd-server:latest
            """
        }

        // Optional: Push the image to Docker registry (if needed)
        stage('Push to Docker Registry') {
            echo 'Pushing Docker image to registry...'
            withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'sibisam2301@gmail.com', passwordVariable: 'devika@123')]) {
                sh """
                    echo devika@123 | docker login -u sibisam2301@gmail.com --password-stdin
                    docker push docker.io/my-httpd-server:latest
                """
            }
        }

    } catch (Exception e) {
        // In case of failure, print the error and rethrow
        currentBuild.result = 'FAILURE'
        echo "Error: ${e.getMessage()}"
        throw e
    }
}
