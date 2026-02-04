pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
        ECR_REPO = "760022212905.dkr.ecr.ap-south-1.amazonaws.com/flask-app:latest"
        IMAGE_TAG = "latest"
        CLUSTER_NAME = "devops-eks-cluster"
    }

    stages {

        stage("Checkout Code") {
            steps {
                git branch: "main",
                    url: "https://github.com/AniketKasurde/eks-ci-cd.git"
            }
        }

        stage("Login to ECR") {
            steps {
                sh """
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin $ECR_REPO
                """
            }
        }

        stage("Build Docker Image") {
            steps {
                sh "docker build -t flask-app ."
            }
        }

        stage("Tag Image") {
            steps {
                sh "docker tag flask-app:latest $ECR_REPO:$IMAGE_TAG"
            }
        }

        stage("Push to ECR") {
            steps {
                sh "docker push $ECR_REPO:$IMAGE_TAG"
            }
        }

        stage("Deploy to EKS") {
            steps {
                sh """
                aws eks update-kubeconfig --region $AWS_REGION --name $CLUSTER_NAME
                kubectl apply -f k8s/deployment.yaml
                kubectl apply -f k8s/service.yaml
                """
            }
        }
    }
}
