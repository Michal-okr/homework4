Nainstalujte AWS CLI
○ https://docs.aws.amazon.com/cli/latest/userguide/getting-started-
install.html#getting-started-install-instructions
● Nastavte AWS credentials (AWS CLI nebo env variables)
○ https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-envvars.html
● Vytvořte Terraform projekt s následující strukturou:
● main.tf - hlavní konfigurace
● variables.tf - definice proměnných
● outputs.tf - výstupy
● Vytvořte EC2 instanci s:
● AMI: Amazon Linux 2023 (najděte aktuální AMI ID)
● Instance type: t2.micro
● Otestujte: terraform plan a terraform apply
● Cleanup: terraform destroy