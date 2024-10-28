# Commands to setup load-balance controller
export CLUSTER_REGION=us-east-1
export CLUSTER_VPC=$(aws eks describe-cluster --name web-quickstart --region $CLUSTER_REGION --query "cluster.resourcesVpcConfig.vpcId" --output text)

helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --namespace kube-system \
    --set clusterName=web-quickstart \
    --set serviceAccount.create=false \
    --set region=${CLUSTER_REGION} \
    --set vpcId=${CLUSTER_VPC} \
    --set serviceAccount.name=aws-load-balancer-controller
            