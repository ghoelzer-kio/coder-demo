# Install PostgreSQL
WRITER_ENDPOINT=$(aws rds describe-db-clusters \
    --db-cluster-identifier coder-postgres-cluster \
    --query 'DBClusters[0].Endpoint' \
    --output text)

PORT=$(aws rds describe-db-clusters \
    --db-cluster-identifier coder-postgres-cluster \
    --query 'DBClusters[0].Port' \
    --output text)

# Example psql connection command using the variables
echo "psql --host=$WRITER_ENDPOINT --port=$PORT --username=dbadmin --dbname=postgres"

kubectl create secret generic coder-db-url -n coder \
  --from-literal=url="postgres://coderusername:coderpassword123@coder-postgres-cluster.cluster-cnqoyswswd9r.us-east-1.rds.amazonaws.com:5432/coder-postgres-instance"

