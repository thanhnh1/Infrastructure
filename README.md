## Infrastructure
* This repository contains resources for infrastructure provisioning, consisting of two main parts: modules and infrastructure for environments (non-prod, followed by pre-prod and prod)
  - **modules**: includes modules for services such as beanstalk, iam, certificate, s3 bucket, which can be reused in multiple environments
  - **infrastructure** for environments: an example here is a non-prod environment, to add other environments (pre-prod, prod), we will add pre-prod, prod folders like non -prod folders but with different input variable values.
    - Configure a _terragrunt.hcl_ file at the root folder for provider configuration tasks, state file, and lock state.
    - The infrastructure uses terragrunt to work on multiple different environments, all variables are placed inside the input of the terragrunt.hcl file.
    - About workflows, just like the approach to application deployment, a generic action is defined, then we will define workflows for actions like plan, apply, destroy using github action.

## To do
* I haven't had enough time to set up the flow deployment, and especially my AWS accounts have been disabled and can't be tested right now.
* For the future:
  - Set up flows for plan, apply, and destroy. Basically, the idea would be to initialize a generic flow for deployment, with the commands (plan, apply, destroy) as a variable, and use functions accordingly.
  - Then, define separate flows: plan, apply, and destroy using the generic flow and passing environment variables here.
