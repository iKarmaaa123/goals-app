<h1>Goals Application</h1>

<h2> Overview </h2>

This project involves deploying a node.js goals-management application, which allows users to create and manage their own goals. The technologies I used in this project were Terraform, Docker, AWS, GitHub Actions, and Node.js. Terraform modules were used to create code that was both reusable and adhered to standard practices. 

AWS services such as ECS, ECR, VPC, Route53, CloudWatch, and ACM were utilised for this project. Best practices were followed and implemented within the project. Git pre-commit hooks were also used to ensure Terraform code was scanned and adhered to best practices before being committed and pushed to GitHub.

This README outlines step-by-step instructions for setting up and running your Docker containers locally, pushing your Docker images to AWS ECR, and setting up the AWS infrastructure to deploy the containerised application.

<h2> Prerequisites </h2>

To follow this project you will need the following installed:

🛠 Prerequisites
Before starting on this project, be sure to have the following installed on your computer:

- ✅ An AWS Account - [Create An Account Here](https://aws.amazon.com/free/?trk=ce1f55b8-6da8-4aa2-af36-3f11e9a449ae&sc_channel=ps&ef_id=Cj0KCQjw782_BhDjARIsABTv_JCWZitQyH0tU_lYElDDQ9HdBabDxB-tKSgYDsRiU0N_XqiVVpjvBTUaAmR7EALw_wcB:G:s&s_kwcid=AL!4422!3!433803621002!e!!g!!aws%20sign%20up!9762827897!98496538743&gclid=Cj0KCQjw782_BhDjARIsABTv_JCWZitQyH0tU_lYElDDQ9HdBabDxB-tKSgYDsRiU0N_XqiVVpjvBTUaAmR7EALw_wcB&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)

- ✅ Terraform - [Download & Install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

- ✅ Docker - [Download & Installl](https://www.docker.com/get-started/)

For this specific project you can use whatever application you want. Ensure the application works on your local machine before containerising it. Also, be wary of what application port your application is listening to, and that you are mapping the correct host network port to the container.

<h2> Architectural diagram of the project </h2>

Below is a visual architectural representation of the infrastructure that we are going to be setting up in this project:

![Architecture](images/Architecture.drawio.png)

<h2> Project Directory Structure </h2>

Here is a view of the project's directory structure:

```hcl
|-- README.md
|-- goals-app
|   |-- Dockerfile
|   |-- package.json
|   |-- public
|   |   `-- styles.css
|   `-- server.js
|-- images
|   |-- Architecture.drawio.png
|   |-- image-1.png
|   |-- image-2.png
|   `-- image.png
|-- main
|   |-- main.tf
|   |-- terraform.tfvars
|   |-- variables.tf
|   `-- versions.tf
`-- modules
    |-- ACM
    |   |-- main.tf
    |   |-- output.tf
    |   `-- variables.tf
    |-- ALB
    |   |-- main.tf
    |   |-- output.tf
    |   `-- variables.tf
    |-- CloudWatch
    |   |-- main.tf
    |   |-- output.tf
    |   `-- variables.tf
    |-- ECS
    |   |-- main.tf
    |   |-- output.tf
    |   `-- variables.tf
    |-- IAM
    |   |-- main.tf
    |   |-- output.tf
    |   `-- variables.tf
    |-- Route53
    |   |-- main.tf
    |   |-- output.tf
    |   `-- variables.tf
    `-- VPC
        |-- main.tf
        |-- output.tf
        `-- variables.tf
```

<h2> Step 1: Running the node.js application on a container locally </h2>
We are going to be testing the application on a container running on our local machine before having it run on AWS ECS. To do this you will need to build the Docker image by creating a Dockerfile that will handle the application dependencies and setup needed for the app to work within the container:

```hcl
FROM node:22-alpine as Build

WORKDIR /app

COPY package.json .

COPY . .

RUN npm install

FROM node:22-alpine

WORKDIR /app

COPY --from=Build /app /app

EXPOSE 80

CMD ["node", "server.js"]
```

This Dockerfile takes advantage of multi-stage builds to help optimise and speed up Docker image build times. This helps reduce the size of the image.

To create the image run the following command:

```hcl
docker build -t goals-image:latest .
```

To start up the container using the Docker image you just built, run the following command:

```hcl
docker run -d -p 80:80 --name goals-container goals-image
```

Run `docker ps` to ensure the container is running.

To access your container that you just started up you will have to connect to it through localhost - for example in this case: http://locahost:80

If you can access your application, you have successfully connected to your container via your localhost. If you are having connections make sure you have probably set up everything and that you have exposed the right ports for your container.

<h2> Step 2: Creating an AWS ECR Image Repository </h2>

Next, create an ECR repository on AWS ECR:
<img width="1895" height="287" alt="image" src="https://github.com/user-attachments/assets/d9449c91-5ac5-46c5-a3c7-9f219ec1c41e" />

<h2> Step 3: Pushing Docker image to ECR </h2>

After getting the container running on your local machine, it is time to deploy this container to AWS ECS. Before we can do that, we need to push our Docker image to AWS ECR, so that AWS ECS can pull our image from AWS ECR repository.

Run the following command to generate an authentication token that you need to authenticate with AWS ECR to push your Docker images to it:

```hcl
aws ecr get-login-password --region <region_name>
```

Run the following command to authenticate with AWS ECR:

```hcl
aws ecr --region <region> | docker login -u AWS -p <authentication_token> <repo_uri>
```

Now tag your docker image with the ECR Registry:

```hcl
docker tag <source_image_tag> <target_ecr_repo_uri>
```

Now push your docker image to AWS ECR:

```hcl
docker push <ecr-repo-uri>
```

You should now be able to see your Docker image within your AWS ECR repo:

![image](https://github.com/user-attachments/assets/d8442901-b3be-4396-bd29-7bf24e358490)

<h2> Step 4: Setting up the application to run on AWS ECS </h2>

Now that we have our container image in AWS ECR, it is time to run our application within AWS ECS.

In the cloned repo you will see a directory called modules  that contains Terraform modules such as an ECS module, ALB module, CloudWatch module, Route 53 module, and a VPC module. To deploy the infrastructure run the ``` terraform init ``` command to initialise your current working directory, install the provider plugins, and install the modules that we have instantiated within the main.tf file. After doing this, run the ```terraform plan``` command to see the plan execution and then run ```terraform apply``` to deploy the infrastructure:

![image](https://github.com/user-attachments/assets/5bf21d8c-9055-43a9-ba69-6ca61810835b)

<h2> Step 5: Accessing the web application </h2>

Wait for your ECS tasks to be running, and you should be able to access the application by typing in ikarmaaa123.com (or the domain name you have created). You should be directed to the webpage:

![image](https://github.com/user-attachments/assets/b12a4bc8-595e-4a1b-baa0-8fffc77aad1f)

<h2> Step 6: Cleaning up </h2>

Well done, you now have successfully deployed your containerised application to AWS ECS and can access it through your own created domain name over an encrypted connection. Now it is important to delete your resources so that you do not incur any costs. In your current working directory that you are in run the ``` terraform destroy -auto-approve ``` command to destroy your resources:

![image](https://github.com/user-attachments/assets/b742e748-95b3-4599-9988-5304dce1f55f)

Also be sure to delete your ECR repository in AWS.


<h2> Step 7: Building Docker image, pushing Docker image, creating and destroying the infrastructure through GitHub Actions CI/CD pipelines </h2>

Now that you have manually built your Docker image, pushed it to ECR, created the infrastructure, and destroyed it manually, it is time to automate this whole process through CI/CD pipelines. After you clone the repository, you will find four GitHub Actions CI/CD pipeline YAML configuration files - ```docker.yml```, ```plan.yml```, ```apply.yml``` and ```destroy.yml```. 

The ```docker.yml``` workflow automates the creation of the container image, performing security checks on the container image, and pushing the container image to AWS ECR. The ```plan.yml``` workflow automates the plan execution for the resources that are going to be deployed. The ```apply.yml``` workflow automates the deployment process for your Terraform resources. The ```destroy.yml``` destroys the whole infrastructure. After pushing to your GitHub, to run these pipelines navigate over to actions at the top:

![image](https://github.com/user-attachments/assets/acf85475-e22d-4158-a9fa-c5b283faf4c7)

After you have clicked 'actions', on the left you will see a list of workflows:

![image](images/image-1.png)

Click on the ```Docker Workflow``` workflow and then press 'run workflow':

![image](images/image.png)

You should see your workflow running:

![alt text](images/image-2.png)

After you have ran the first workflow, run the ```Terraform Plan Workflow``` and then the ```Terraform Apply Workflow```.

After having successfully ran all of the workflows, type in 'ikarmaa123.com' in your browser and you should be prompted with the same goals app web page that we deployed before manually:

![image](https://github.com/user-attachments/assets/f270d19c-24cc-412a-952e-1da4f0dd13cb)

Now destroy the infrastructure by running the ```Terraform Destroy Workflow```:

![image](https://github.com/user-attachments/assets/e5038c7d-eab7-41a7-bf4c-0f0667538190)
