<h1>End-to-End AWS ECS Project</h1>

<h2> Project Overview </h2>

This AWS ECS end-to-end project involves deploying and running a Node.js goals-management application to AWS ECS. The technologies I used were Terraform, Docker, AWS, GitHub Actions, and Node.js. Terraform modules were used to create code that was both reusable and adhered to standard practices when writing Terraform code. AWS services such as ECS, ECR, VPC, Route53, CloudWatch, and ACM were utilised for this project. Best practices were followed and implemented within the project, as you will see when we discussed some of the various static analysis tools I used to ensure my Terraform and Docker image addressed any vulnerabilities and adhered to best security practices. Git pre-commit hooks were also used to ensure Terraform code was scanned and adhered to best practices before being committed and pushed to GitHub.

<h2> Architectural diagram of project </h2>

<h2> Exporting Credentials </h2>
When working with providers like MongoDB Atlas and AWS, having credentials that grant programmatic access to AWS is crucial. Without these credentials, deploying the necessary resources to AWS will be impossible. The following credentials need to be exported using a Windows terminal.

<h2> Step 1: Setting up credentials </h2>
When working with providers AWS, having credentials that grant programmatic access to AWS is crucial. Without these credentials, deploying the necessary resources to AWS will be impossible. The following credentials need to be exported in the terminal.


```hcl
export AWS_ACCESS_KEY_ID="<INSERT YOUR KEY HERE>"
export AWS_SECRET_ACCESS_KEY="<INSERT YOUR KEY HERE>"
export AWS_DEFAULT_REGION="<INSERT AWS REGION HERE>"
```

Please avoid hardcoding your credentials as this poses major security risks for your AWS IAM account.


<h2> Step 2: Setting up your Terraform resources </h2>

