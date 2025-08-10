# 🚀 Terraform GCP Shared VPC Scaffold

A production-ready Terraform scaffold for deploying modern applications on Google Cloud Platform (GCP) using a secure Shared VPC architecture. This repository provides a comprehensive set of reusable modules and live environment examples (dev/prod) to rapidly establish a robust and scalable foundation for your infrastructure.

It is designed to be a powerful boilerplate, demonstrating IaC best practices by separating reusable components (modules) from environment-specific configurations (env). Whether you're deploying services on GKE, Cloud Run, or managing databases with Cloud SQL, this scaffold provides the core building blocks to accelerate your cloud journey.

---

## Architecture Overview 🏗️

This repository implements a GCP Landing Zone pattern. It uses a dedicated Host Project to manage shared network resources (like the Shared VPC and firewall rules) and multiple Service Projects to host applications and services. This separation enhances security, simplifies network administration, and improves scalability.

---

## Key Features ✨

- **Secure Network Foundation:** Implements a best-practice Shared VPC architecture for centralized network control.
- **Modular & Reusable:** A rich library of Terraform modules for dozens of GCP services, including GKE, Cloud Run, Cloud SQL, IAM, Load Balancing, and more.
- **Multi-Environment Ready:** Pre-configured for dev and prod environments, showcasing how to manage different configurations effectively.
- **Comprehensive Examples:** Demonstrates how to compose modules to create complete, deployable application stacks.
- **IAM & Security Best Practices:** Includes configurations for service accounts, custom IAM roles, and Workload Identity Federation.
- **CI/CD Ready:** Structured for easy integration with CI/CD pipelines to automate your infrastructure deployments.

---

## Understanding the Repository Structure 📂

The structure of this repository is intentionally designed to separate concerns, promote reusability, and scale effectively. It's built on two core concepts: reusable modules and environment-specific live configurations.

```text
.
├── 📁 env/      # Live infrastructure configurations for each environment.
│   ├── 📁 host/  # Manages the Shared VPC and central network resources.
│   ├── 📁 dev/   # 'dev' environment service project configurations.
│   └── 📁 prod/  # 'prod' environment service project configurations.
└── 📁 modules/  # Reusable, versioned Terraform modules for GCP services.
```

### The `modules/` Directory
This is the heart of reusability. Each subdirectory in `modules/` is a self-contained Terraform module for a specific GCP service (e.g., gke, cloud-run, cloudsql). These modules are designed to be generic and configurable, accepting variables to define their behavior. This approach prevents code duplication and ensures consistency across all environments.

### The `env/` Directory
This directory contains the "live" Terraform code that deploys your infrastructure. It's broken down by environment (`dev`, `prod`) and purpose (`host`).

#### `env/host` - The Shared VPC Project
The `host` directory is responsible for provisioning the central networking infrastructure. This includes:

- **Shared VPC:** The core VPC network, subnets, and routes.
- **Firewall Rules:** Centralized firewall policies that apply to all service projects.
- **NAT Gateway & Cloud VPN:** Egress and ingress connectivity for the entire network.

By managing the network in a central project, you ensure consistent policy enforcement and simplify administration.

#### `env/dev` & `env/prod` - The Service Projects
These directories define the infrastructure for your application environments. They are attached to the Shared VPC from the host project. Within each environment, resources are further organized into two logical groups:

- **`common/`**: Contains foundational resources that are shared by all applications within that environment. This typically includes:
  - IAM: Project-level IAM bindings and service accounts.
  - GKE Clusters: A shared cluster for multiple services.
  - Cloud SQL Instances: A shared database instance.
  - Artifact Registry: A common repository for container images.

- **`apps/`**: Contains resources that are specific to a single application or microservice. Each application (`app-1`, `app-2`) has its own directory, defining resources like:
  - Cloud Run Service: The application's serverless deployment.
  - Load Balancer & NEGs: The specific networking configuration to expose the application.
  - IAM Bindings: Granular permissions for that specific application's service account.
  - Secrets: Application-specific secrets stored in Secret Manager.

This separation ensures that changes to one application don't impact another and allows for independent application deployment lifecycles.

---

## What's Inside? 📦

| Service                | Module Path                              |
|------------------------|------------------------------------------|
| **GKE**                | `modules/gke`                            |
| **Cloud Run**          | `modules/cloud-run`                      |
| **Cloud SQL**          | `modules/cloudsql`                       |
| **Shared VPC**         | `modules/networking/shared-vpc`          |
| **Load Balancing**     | `modules/networking/loadbalancer`        |
| **IAM**                | `modules/iam`                            |
| **Artifact Registry**  | `modules/artifact-registry`              |
| **Memorystore (Redis)**| `modules/memorystore-redis`              |
| **And many more...**   | `modules/`                                |

---

## Getting Started 🚀

### Prerequisites

- Google Cloud SDK installed and configured.
- Terraform installed.
- A GCP Organization and a Billing Account.
- Appropriate IAM permissions (Project Creator, Billing Account User, etc.).

### Deployment Steps

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/parth-koli67/terraform-gcp-shared-vpc-scaffold.git
   cd terraform-gcp-shared-vpc-scaffold
   ```

2. **Configure Backend:**
   Update the `backend.tf` files in each environment directory (`env/dev`, `env/prod`, etc.) to point to your GCS bucket for storing Terraform state.

3. **Set Variables:**
   Review and update the `terraform.tfvars` files within each environment to match your desired project IDs, regions, and other configurations.

4. **Initialize & Apply:**
   Deploy the infrastructure, starting with the host project.
   ```bash
   # Navigate to the host environment's VPC configuration
   cd env/host/networking/vpc

   # Initialize Terraform
   terraform init

   # Plan and apply
   terraform plan
   terraform apply
   ```

   Repeat the `init`, `plan`, and `apply` steps for other components and environments as needed.

---

## Contributing 🤝

Contributions are welcome! Please feel free to submit any suggestions or open an issue for any bugs, feature requests, or improvements.
