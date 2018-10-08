# Terraform

**Add Instance**

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

**Change Instance**

after changing the `.tf` config, run:

```
terraform apply
```

Excerpt of the output:

```
-/+ aws_instance.example (new resource required)
```

=> The `-/+` shows, that this resource is going to be **destroyed and recreated**.

**Destroy Instance**

```
terraform destroy
```

Excerpt of the output:

```
  - aws_instance.example
```

=> The `-` shows, that this resource is going to be **destroyed**.

**Implicit Dependencies**

modifying the config file:

```
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}" // EC2 instance 'aws_instance' to assign the IP to
}
```

=> creates an implicity dependency on the instance `aws_instance` named `example`.
=> Terraform knows that the `aws_instance` must be created before the `aws_eip`.

To model dependencies, implicit dependencies via interpolation expressions should be used, whenever possible. Alternatively, the `depends_on` [can be used][0].



[0]: https://www.terraform.io/intro/getting-started/dependencies.html