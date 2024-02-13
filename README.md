# Prometheus and Grafana Ansible Setup

This repository contains Ansible playbooks and roles designed to facilitate the installation and configuration of Prometheus and Grafana on your servers. This setup is flexible enough to support an arbitrary number of servers for monitoring purposes.

## Requirements

To utilize this repository effectively:

1. Clone or copy this repository onto your Ansible controller machine (Server A).
2. Execute the provided playbooks in the specified order.

### Installation Steps

1. **Install Prometheus (with Node Exporter):** To install Prometheus on Server B and configure it to monitor itself with Node Exporter, run:

   ```
   ansible-playbook -i inventory/hosts.yml playbooks/prometheus.yml
   ```dsdssdsds

2. **Install Grafana:** To install Grafana on Server C for visualizing metrics collected by Prometheus, execute:

   ```
   ansible-playbook -i inventory/hosts.yml playbooks/grafana.yml
   ```

### Configuration for Additional Servers

To extend monitoring to additional servers (e.g., Slave1, Slave2, etc.) with Prometheus:

1. Deploy Node Exporter on each server you wish to monitor by running the Node Exporter role/playbook provided in this repository.

2. Update the `prometheus.yml.j2` template to include the new targets. For example:

   ```yaml
   scrape_configs:
     - job_name: 'node'
       static_configs:
         - targets: ['slave1:9100', 'slave2:9100']
   ```

3. Re-run the Prometheus playbook to apply the updated configuration.

## Role Variables

The roles within this repository are configurable to suit your environment. Here are some of the key variables:

- **Prometheus:**
  - `prometheus_version`: Specifies the version of Prometheus to install.
  - `prometheus_home`: Defines the directory where Prometheus configuration and data will be stored.
  - `prometheus_download_url`: URL to download the Prometheus binary.

- **Node Exporter:**
  - `node_exporter_version`: Specifies the version of Node Exporter to install.
  - `node_exporter_download_url`: URL to download the Node Exporter binary.

- **Grafana:**
  - `grafana_version`: Specifies the version of Grafana to install.

Variables can be defined in `roles/<role_name>/defaults/main.yml` or overridden in `vars/main.yml` or at the playbook level.

## Example Inventory Setup

Your `inventory/hosts.yml` might look something like this:

```yaml
all:
  children:
    prometheus:
      hosts:
        serverB:
          ansible_host: <IP_of_Server_B>
    grafana:
      hosts:
        serverC:
          ansible_host: <IP_of_Server_C>
    monitored:
      hosts:
        slave1:
          ansible_host: <IP_of_Slave1>
        slave2:
          ansible_host: <IP_of_Slave2>
```

Replace `<IP_of_...>` with the actual IP addresses of your servers.

## Running the Playbooks

After setting up your inventory, you can run the playbooks as outlined in the Installation Steps section. Ensure you have SSH access and the necessary privileges on the target servers.

This README provides a concise guide to deploying a monitoring solution with Prometheus and Grafana across multiple servers using Ansible. Adjustments may be necessary to accommodate the specifics of your environment, such as network configurations and security policies.
