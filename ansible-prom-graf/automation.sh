#!/bin/bash

# Update system packages and install Ansible
sudo apt update -y


# Check for existing SSH keys, generate if not exists
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 2048 -N '' -f ~/.ssh/id_rsa
else
    echo "SSH key already exists."
fi

# Read server IPs from server.txt and copy the SSH key
SERVER_FILE="server.txt"
GROUP=""

if [ -f "$SERVER_FILE" ]; then
    while IFS= read -r line; do
        if [[ $line == \[*\] ]]; then
            GROUP=${line:1:-1} # Extract group name from brackets
        else
            server_ip=$line
            echo "Copying SSH key to $server_ip in group $GROUP..."
            ssh-copy-id ubuntu@$server_ip || echo "Failed to copy SSH key to $server_ip. Ensure password authentication is enabled."
        fi
    done < "$SERVER_FILE"
else
    echo "File $SERVER_FILE not found. Please make sure it exists in the current directory."
    exit 1
fi

# Clone the Ansible repository
REPO_DIR="/home/ubuntu/ansible-prom-graf"
if [ -d "$REPO_DIR" ]; then
    read -p "Directory $REPO_DIR already exists. Remove it and clone again? [y/N]: " confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
        rm -rf "$REPO_DIR"
    fi
fi
git clone https://github.com/avargh879local/ansible.git "$REPO_DIR"

# Change directory to the cloned repository
cd "$REPO_DIR"/ansible-prom-graf|| exit

# Run Ansible playbooks based on groups
ansible-playbook -i inventory/hosts.yml playbooks/prometheus.yaml
ansible-playbook -i inventory/hosts.yml playbooks/grafana.yaml
ansible-playbook -i inventory/hosts.yml playbooks/nodeexporter.yaml
