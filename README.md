# CyberArk PAM Deployment with Terraform

## Overview  
Welcome to the **CyberArk PAM Terraform Modules** repository! This project provides robust tools and scripts to simplify the deployment of **CyberArk's Privileged Access Manager (PAM)** on **Microsoft Azure**.  

With our Terraform modules, you can deploy CyberArk PAM across various architectures:  
- **Fully cloud-native**
- **Cross-region**
- **Hybrid**

These solutions are designed to be flexible, scalable, and adaptable to your organization's specific requirements.

## Features  
- **Modular architecture**: Use only the components you need for your environment.  
- **Customizable configurations**: Adjust settings to fit your organization’s unique PAM deployment.  
- **Examples included**: Step-by-step examples to help you get started quickly.  

## Prerequisites  
Before using these modules, ensure you have the following:  
- A valid **CyberArk PAM license**  
- **Terraform** installed  
- Azure account with necessary permissions for deploying resources  

Refer to the [Prerequisites](https://docs.cyberark.com/pam-self-hosted/latest/en/content/pas%20cloud/deploy_terraform.htm#Prerequisites) section in our documentation for detailed setup instructions.

## Usage  
Please refer to the 'Usage' section of each module's README file for detailed instructions:  
- [PAM Network Module Usage](/modules/pam_network/#Usage): This module sets up the network infrastructure required for CyberArk PAM, including VPCs, subnets, and security groups.  
- [Vault Module Usage](/modules/vault/#Usage): This module deploys and configures the CyberArk Vault, the core component for managing privileged accounts and credentials.  
- [Vault DR Module Usage](/modules/vault_dr/#Usage): This module sets up Disaster Recovery (DR) for the CyberArk Vault, ensuring high availability and data redundancy.  
- [Component Module Usage](/modules/component/#Usage): This module deploys additional CyberArk components required for a complete PAM solution, such as PVWA, CPM, and PSM.  

## Documentation  
- [User Guide](https://docs.cyberark.com/pam-self-hosted/latest/en/content/pas%20cloud/deploy_terraform.htm): Comprehensive instructions for deployment, configuration, and troubleshooting.  
- [Modules](/modules): Detailed documentation for each Terraform module.  
- [Examples](/examples): Ready-to-use examples for various architectures.  

## Licensing  
This repository is subject to the following licenses:  
- **CyberArk Privileged Access Manager**: Licensed under the [CyberArk Software EULA](https://www.cyberark.com/EULA.pdf).  
- **Terraform templates**: Licensed under the Apache License, Version 2.0 ([LICENSE](LICENSE)).  

## Contributing  
We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for more details.

## About  
CyberArk is a global leader in **Identity Security**, providing powerful solutions for managing privileged access. Learn more at [www.cyberark.com](https://www.cyberark.com).  