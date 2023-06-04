# Jenkins-CI-CD-K8S-project

This repository provides a practical example of setting up a Jenkins CI/CD pipeline for a .NET application on an AKS (Azure Kubernetes Service) cluster.<br>
The project utilizes an AKS setup using Terraform to provision the kubernetes cluster.<br> 
The Jenkins master is deployed as a pod and uses a dynamic Jenkins agent within the AKS cluster and, taking advantage of the scalability and reliability offered by Kubernetes.<br> 
The pipeline automates the build process, creates a Docker image of the application, pushes it to Docker Hub, deploys it to the AKS cluster, and exposes a service for access.<br>


## Prerequisites
    Azure CLI
    kubectl command-line tool
    Terraform CLI 


## SETUP
   Follow the steps below to set up the project:
   
   
### Clone the git repository:
   Clone the Git repository by running the following command:
   ```
     git clone https://github.com/oratar/Jenkins-CI-CD-K8S-project.git
   ```
   
   
### Create the AKS cluster using terraform:
Navigate to the terraform/AKS directory and run the following commands to create the AKS cluster: 
```
   terraform init 
   terraform apply 
```


### Setup Jenkins pod:
To set up the Jenkins pod with a local persistent volume in the devops namespace,<br>
execute the provided script: 
```
   bash devops/setup-jenkins.sh
```
This script deploys the Jenkins pod with a customized Docker image that includes pre-installed plugins like Kubernetes and Kubernetes CLI.<br>
Additionally, it creates the necessary environment for the Jenkins pod, including namespaces, configuration of the persistent volume, and exposes a NodePort service.<br>
Once the Jenkins pod is successfully deployed, you can access the Jenkins master's UI through the web using the following URL: http://<node_ip>:<node_port> 
To obtain the root password for intial access, run the following command:<br> 
```
    kubectl logs jenkins -n devops
```
Within the logs, locate the admin password and enter it in the Jenkins UI.<br>
Add your Git and DockerHub credentials in the Jenkins credentials.<br>
For more information, refer to the official Jenkins guide: https://www.jenkins.io/doc/book/pipeline/getting-started/.<br>
Create a new pipeline project and configure the project settings following the official Jenkins guide: https://www.jenkins.io/doc/book/pipeline/getting-started/.<br>

    
### Configure dynamic Jenkins agent:
For each job, the dynamic agent will set up containers specified in the manifests/jenkins/builder.yaml file.<br> 
To connect your Kubernetes cluster to Jenkins,<br>
Add the kubeconfig file of your aks cluster located at the terraform/AKS directory, as a secret file in the jenkins credentials.<br> 
In the Jenkins UI, configure Jenkins to use Kubernetes dynamic agent using the kubernetes pluging by navigating to "Manage Nodes and Clouds" -> "Configure Clouds" -> "Add a new cloud" -> "Kubernetes".<br> 
Add your cluster information, including the kubeconfig you added to your Jenkins credentials and the Jenkins URL.<br> 
Refer to the official Jenkins guide for detailed instructions on configuring Kubernetes: https://plugins.jenkins.io/kubernetes/.<br> 

    
## Trigger the Pipeline
    
With everything set up, you can now trigger the pipeline and see the magic of your CI/CD pipeline automation happens.<br> 
To access your application, run the following commannd to get the external IP of your load balancer service:<br> 
```
   kubectl get services -n prod
```
Access the application using the following URL: http://<load_balancer_external_ip>.<br> 
    
    
![Screenshot from 2023-06-04 14-03-27](https://github.com/oratar/Jenkins-CI-CD-K8S-project/assets/121873526/4eaefc68-96f1-4a5f-a640-108a64105638)
