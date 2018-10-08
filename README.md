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

**Provisioners**

[Provisioners][1] are used to execute scripts on a local or remote machine as part of resource creation or destruction. 
Multiple `provisioner` blocks can be added to define multiple provisioning steps
```
resource "aws_instance" "web" {
  # ...

  // the 'local-exec' provisioner executes a command locally on the machine
  provisioner "local-exec" {
    command = "echo ${self.private_ip} > file.txt"
  }
}
```

Provisioners are only run when a resource is created.

```
terraform destroy // first, destroy the current instance(s)
terraform apply // , so the provisioner(s) will actually be executed
```

to check, if the provisioner was run, we can execute:

```
cat ip_address.txt // e.g. 34.228.228.189
```


[0]: https://www.terraform.io/intro/getting-started/dependencies.html
[1]: https://www.terraform.io/docs/provisioners/index.html