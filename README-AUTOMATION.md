To ensure the Markdown formatting appears correctly when you copy it into your `.md` file, I'll include the appropriate Markdown symbols for headers, code blocks, and other formatting elements. This will make the text appear structured and colorful when viewed on platforms that render Markdown, such as GitHub.

---

## Automation Script for Monitoring Setup

The `automation.sh` script is designed to automate the setup of a monitoring environment by deploying **Prometheus**, **Grafana**, and **Node Exporter**. It simplifies the process of SSH key management, repository cloning, and Ansible playbook execution.

### **Prerequisites**

Before running the script, ensure each target server is prepared by:

- **Enabling SSH Password Authentication**

  ```bash
  sudo vi /etc/ssh/sshd_config
  # Find and set PasswordAuthentication to yes
  sudo systemctl restart sshd
  ```

- **Setting User Passwords**

  For existing users:
  ```bash
  sudo passwd $USER
  ```

  For new users:
  ```bash
  sudo adduser newusername
  sudo passwd newusername
  ```

### **Script Functionality**

1. **SSH Key Management**: Generates and copies SSH keys to enable passwordless access.
2. **Repository Cloning**: Clones the specified GitHub repository to access Ansible playbooks.
3. **Playbook Execution**: Installs Prometheus, Grafana, and Node Exporter on the designated servers, as outlined in the `servers.txt` file.

### **Usage Instructions**

1. Create a `servers.txt` file in the same directory as the `automation.sh` script, listing server IPs under their respective group names, enclosed in brackets.
2. Run the `automation.sh` script from a host with sudo privileges and ensure all prerequisites are met.
3. Follow any on-screen prompts during the repository cloning and playbook execution processes.

---

Copy and paste the above Markdown text into your `.md` file to maintain the structured and colorful formatting when viewed on a Markdown-rendering platform.