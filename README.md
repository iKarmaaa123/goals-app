<h1>End-to-End AWS ECS Project</h1>

<h2> Project Overview </h2>

This AWS ECS end-to-end project involves deploying and running a Node.js goals-management application, which allows users to create and manage their own goals, to AWS ECS. The technologies I used were Terraform, Docker, AWS, GitHub Actions, and Node.js. Terraform modules were used to create code that was both reusable and adhered to standard practices when writing Terraform code. AWS services such as ECS, ECR, VPC, Route53, CloudWatch, and ACM were utilised for this project. Best practices were followed and implemented within the project, as you will see when we discussed some of the various static analysis tools I used to ensure my Terraform and Docker image addressed any vulnerabilities and adhered to best security practices. Git pre-commit hooks were also used to ensure Terraform code was scanned and adhered to best practices before being committed and pushed to GitHub.

<h2> Architectural diagram of project </h2>

<h2> Exporting Credentials </h2>
When working with providers like MongoDB Atlas and AWS, having credentials that grant programmatic access to AWS is crucial. Without these credentials, deploying the necessary resources to AWS will be impossible. The following credentials need to be exported using a Windows terminal.


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

This Dockerfile takes advantage of multi-stage Docker builds to help optimise and speed up Docker image build times. This helps reduce the size of the image, thus saving storage.

To create the image run the following command:

```hcl
docker build -t goals-image:latest .
```

To start up the container using the Docker image you just built, run the following command:

```hcl
docker run -d -p 80:80 --name goals-container goals-image
```hcl

Run `docker ps` to ensure that the container is up and running.

In order to access your container that you just started up you will have to connect to it through localhost - for example in this case: http://locahost:80.#

<Screenshot of application>

If you see this page it means you have successfully connected to your container on your localhost.

<h2> Step 2: Pushing Docker image to ECR </h2>



