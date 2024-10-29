# Scripts to perform initial code install into existing eks cluster
# First create the DB cluster
# Set your VPC ID as a variable (replace with your VPC ID)
aws rds create-db-subnet-group \
    --db-subnet-group-name coder-db-subnet-group \
    --db-subnet-group-description "Subnet group for Aurora PostgreSQL" \
    --subnet-ids subnet-06843025c3b05c986 subnet-0b9076e346899b256

aws rds create-db-cluster \
    --db-cluster-identifier coder-postgres-cluster \
    --engine aurora-postgresql \
    --engine-version 14.9 \
    --master-username coderusername \
    --master-user-password coderpassword123 \
    --serverless-v2-scaling-configuration MinCapacity=0.5,MaxCapacity=1 \
    --db-subnet-group-name coder-db-subnet-group \
    --vpc-security-group-ids sg-03ac54a029c026db4

# Then create the DB instance in the cluster
aws rds create-db-instance \
    --db-instance-identifier coder-postgres-instance \
    --db-cluster-identifier coder-postgres-cluster \
    --db-instance-class db.serverless \
    --engine aurora-postgresql

# Add Helm Chart for Coder
helm repo add coder-v2 https://helm.coder.com/v2

helm install coder coder-v2/coder \
    --namespace coder \
    --values values.yaml \
    --version 2.15.4
   
