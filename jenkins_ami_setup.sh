### Setting up Jenkins AMI with all necessary dependencies ###

## Instance needs a role that allows admin access to EKS and STS get-caller-identity

sudo yum update –y

# Install java
 wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.rpm
sudo yum install -y jdk-8u141-linux-x64.rpm

# Download jenkins pkg, install, and start
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo service jenkins start

# Install git
sudo yum install git -y

# Install docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Set up jenkins user permissions
sudo groupadd docker
sudo usermod -aG docker jenkins
chmod root:docker /var/run/docker.sock

# Install and configure kubectl
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.9/2019-03-27/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH

# Install IAM Authenticator to allow kubectl to talk to EKS
curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

# Install AWS CLI
sudo apt-get install python3 -y
pip3 install awscli --upgrade --user

# Give Jenkinst root priviledges
sudo usermod -aG wheel jenkins

# # Install KOPS
# curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
# chmod +x kops-linux-amd64
# sudo mv kops-linux-amd64 /usr/local/bin/kops


# Setup kubeconfig file --- Dynamic Section Here!
aws sts get-caller-identity
aws eks --region {REGION} update-kubeconfig --name {CLUSTER_NAME} --role-arn arn:aws:iam::{AWS_ACCOUNT_ID}:role/{ROLE_NAME}


## Install the Docker Pipeline Plugin on Jenkins
## Reboot the ec2 instance to apply user permission changes




