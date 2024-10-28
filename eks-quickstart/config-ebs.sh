# Create base storage classes and smoke test with game-2048 deployment
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/examples/kubernetes/dynamic-provisioning/manifests/storageclass.yaml
kubectl apply -f ebs-pvc.yaml
kubectl apply -f ebs-deployment.yaml
