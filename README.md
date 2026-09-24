# Kubernetes na AWS com Terraform e Ansible
 
Projeto de laboratório para provisionamento e configuração automatizada de um cluster Kubernetes na AWS, utilizando Terraform, Ansible, containerd, kubeadm, Calico e Kubernetes.
 
O objetivo é construir um cluster Kubernetes manualmente, sem utilizar Amazon EKS, automatizando a infraestrutura com Infrastructure as Code e a configuração dos servidores com Ansible.
 
## Arquitetura
 
```text
Internet
   |
   v
Internet Gateway
   |
   v
VPC 10.0.0.0/16
   |
   +-------------------------+
   |                         |
   v                         v
Control Plane             Workers
10.0.1.0/24              10.0.2.0/24
   |                         |
   |                    +----+----+
   |                    |         |
   |                    v         v
   |                 Worker 1  Worker 2
   |
   v
Kubernetes Cluster
   |
   v
Service NGINX
NodePort 30080
   |
   +---------+---------+
   |         |         |
   v         v         v
 Pod       Pod       Pod
NGINX     NGINX     NGINX
 