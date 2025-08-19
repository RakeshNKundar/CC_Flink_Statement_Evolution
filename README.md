# CC Flink statement lifecycle management

This github repo demonstrates a complete lifecycle using:
- A **Python Kafka producer** sending messages in Protobuf to Confluent Cloud Kafka cluster.
- **Terraform scripts** deploying Flink SQL statements using the **Confluent Terraform Provider**.
- Schema evolution from v1 to v2 using Protobuf and Confluent Schema Registry.
- Python Kafka producer producing new events with V2 version of Schema.
- New Flink statements created to migrate from V1 schema to V2 schema for continued events processing.

---

## 🔧 Prerequisites

Make sure you have the following installed:
- [Python 3.12+](https://www.python.org/downloads/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Protoc (Protocol Buffers compiler)](https://github.com/protocolbuffers/protobuf/releases)
- [Confluent Kafka cluster access with Schema Registry and Flink Workspace](https://confluent.cloud)

---

## 🔌 Step 1: Set up the local Environment

### 1.1. Create a Virtual Environment and install python dependencies.

```bash
# Create a virtual environment named venv
python3 -m venv venv
source venv/bin/activate

# Install required python libraries
pip install -r requirements.txt
```

### 1.2. Compile the protobuf schemas

```bash
cd schemas

protoc --proto_path=. --python_out=. *.proto

```


## Step 2: Set up the Environment variables
In the **.env** file add the endpoint and the credentials for both Kafka and Schema registry clusters.

```bash
SCHEMA_REGISTRY_URL=""
SR_API_KEY=""
SR_API_SECRET=""
KAFKA_BOOTSTRAP = ""
KAFKA_API_KEY = ""
KAFKA_API_SECRET = ""
```

Similarly, Add the relevant configs in the terrafor.tfvars file under terraform directory
```bash
CC_CLOUD_API_KEY = ""
CC_CLOUD_API_SECRET = ""
CLOUD_PROVIDER = ""
REGION = ""
ENVIRONMENT_ID = ""
SCHEMA_REGISTRY_ID = ""
SCHEMA_REGISTRY_REST_ENDPOINT = ""
SCHEMA_REGISTRY_API_KEY = ""
SCHEMA_REGISTRY_API_SECRET = ""
CONFLUENT_KAFKA_CLUSTER_ID = ""
KAFKA_API_KEY = ""
KAFKA_API_SECRET = ""
FLINK_API_KEY = ""
FLINK_API_SECRET = ""
FLINK_COMPUTE_POOL_ID = ""
CC_USER_ID = ""
CC_ORGANIZATION_ID = ""
CC_FLINK_REST_ENDPOINT = ""
```
## Step 3: Run the Producer application

```bash
python3 main.py
```

## Step 4: Run terraform script to create Flink statements for data transformation

```bash
cd terraform

terraform init
terraform apply --auto-approve
```

## Step 5: Stop the running Flink statements before new schema version upgrade
In the flink.tf file set the stopped=true to stop the running statements and run 

```bash
terraform apply --auto-approve
```

## Step 6: Upgrade the producer with a new schema and start producing events
**main_v2.py** file registers a new V2 version schema to the Schema registry and produces events with matching new schema. 

```bash
python3 main_v2.py
```

## Step 7: Upgrade the Flink statements through terraform
Uncomment everything on **flink_v2.tf** file which contains the Flink statements to work with the new schemas and run 

```bash
terraform apply --auto-approve
```