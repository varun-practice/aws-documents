# AWS CLI
sudo yum install awscli -y
aws --version

#EKSCTL
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

#KUBECTL
curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
kubectl version --short --client

# CLUSTER
eksctl create cluster --version=1.33 --name=capstone --nodes=2 --managed --region=us-east-1 --zones us-east-1a,us-east-1b,us-east-1c --node-type t3.medium --asg-access #—with-oidc
aws eks --region us-east-1 update-kubeconfig --name capstone
kubectl get nodes

#METRICS SERVER
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl get pods -n kube-system | grep metrics-server

# SAMPLE APP
kubectl create deployment nginx --image=nginx
kubectl scale deployment nginx --replicas=2
kubectl get deployments
kubectl get pods

# SERVICE
kubectl expose deployment nginx --port=80 --type=LoadBalancer
kubectl get svc