# Terraform

**Getting started**

```
terraform init
terraform apply # 1. create instance from config
```

This will apply the example.tf config.
Excerpt of the output:

```
  + aws_instance.example
```

=> The `+` shows, that this resource is going to be **added**.

- will create an ec2 instance
- will save all variables to the `terraform.tfstate` file (make sure to check this into source control along with the config file, since it's needed to know, what instance terraform is managing)

```
terraform show # 2. inspect current state
```

=> will output the newly created instance