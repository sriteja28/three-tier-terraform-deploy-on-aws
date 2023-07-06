### Three-tier terraform architecture on AWS cloud
> AWS | Terraform | Bash Scripting

![alt text](https://github.com/sriteja28/three-tier-terraform-deploy-on-aws/blob/main/3-tier-prod.drawio.pdf) 

<object data="https://github.com/sriteja28/three-tier-terraform-deploy-on-aws/blob/main/3-tier-prod.drawio.pdf" type="application/pdf" width="700px" height="700px">
    <embed src="http://yoursite.com/the.pdf">
        <p>This browser does not support PDFs. Please download the PDF to view it: <a href="http://yoursite.com/the.pdf">Download PDF</a>.</p>
    </embed>
</object>

Desired terraform folder structure
```css
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── backend.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ...
└── ...
```

Copy the updated script into a new file, such as create_structure.sh. Save the file and make it executable by running the following command:
```bash
chmod +x create_structure.sh
```

To run the script, use the following command:
```bash
./create_structure.sh
```
This will create the directory structure and files for the three-tier architecture in the terraform directory, with the respective content for each Terraform file.
