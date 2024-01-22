### This is an example project to set up AWS resources using Terraform private modules.


#### Prerequisite:
AWS Account & authentication
Installed Terraform

#### Initialization
Go to ./ecs_task/backend
Run 'terraform init'
Take note of the output
Reference output in ./ecs_task/backend-init.tf
Go to /ecs_task 
Run 'terraform init' again - This initializes the backend for remote state to be stored in s3 and lock file in DynamoDB
Adjust desired values in main.tf
Run 'terraform plan'
If result is satisfying, run 'terraform apply -auto-approve'
