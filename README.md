"# Udemy-Master-DevOps-using-Kubernetes-on-AWS-using-real-world-scenarios." 

Platform: udemy.com
URL: https://www.udemy.com/course/devops-projects-using-kubernetes-a-hands-on-guide/

Skills: DevOps/SRE/Platform Engineering

Products/Tools:Kops, Kubernetes, AWS, Packer, Ansible

NOTES:

KOPS

#### Using Kops for kubernetes deployment on AWS ####

[...]
### DNS setup
[...]
dig NS kubernetes2.carlosengels.com
.

### S3 Bucket config
aws s3api create-bucket --bucket s3.kubernetes2.carlosengels.com --region us-east-2 --create-bucket-configuration LocationConstraint=us-east-2

aws s3api put-bucket-versioning --bucket s3.kubernetes2.carlosengels.com --versioning-configuration Status=Enabled


### Deploy KOPS
export KOPS_CLUSTER_NAME=kubernetes2.carlosengels.com
export KOPS_STATE_STORE=s3://s3.kubernetes2.carlosengels.com
ssh-keygen -t rsa -f kops

kops create cluster --node-count=3 --node-size=t3.large --zones=us-east-2a,us-east-2b,us-east-2c --control-plane-size=t3.large --control-plane-zones=us-east-2a,us-east-2b,us-east-2c --ssh-public-key=kops.pub

kops update cluster --name kubernetes2.carlosengels.com --yes --admin

kubectl get nodes
<ERROR and troubleshooting TLS issues, had to add the Self-Signed Certificate to Trusted CA Bundle, then command worked>

### SSH to cluster
chmod 400 kops
ssh -i kops ubuntu@api.kubernetes2.carlosengels.com

kops delete cluster --yes



#### EKS with kubectl

### Set up eksctl
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_arm64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

### Deploy & delete cluster
[create cluster.yaml file or use eksctl default]

eksctl create cluster -f cluster.yaml

eks delete cluster --name basic-cluster


#### kubeadm, Packer, Terraform

### Packer Install
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install packer
packer version

### Install Ansible
sudo yum update -y
sudo yum install python3-pip -y
sudo pip install ansible
ansible --version

### Make AMI
