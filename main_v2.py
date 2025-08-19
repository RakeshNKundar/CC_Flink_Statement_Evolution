from confluent_kafka import SerializingProducer
from confluent_kafka.serialization import MessageField
from confluent_kafka.schema_registry import SchemaRegistryClient
from confluent_kafka.schema_registry.protobuf import ProtobufSerializer
from schemas import product_v2_pb2, orders_v2_pb2 
import uuid, random, time, os
from dotenv import load_dotenv
from faker import Faker

faker = Faker()

load_dotenv()

# Configs
schema_registry_conf = {
    'url': os.getenv('SCHEMA_REGISTRY_URL'),
    'basic.auth.user.info': f"{os.getenv('SR_API_KEY')}:{os.getenv('SR_API_SECRET')}"
}

producer_conf_product = {
    'bootstrap.servers': os.getenv('KAFKA_BOOTSTRAP'),
    'sasl.mechanism': 'PLAIN',
    'security.protocol': 'SASL_SSL',
    'sasl.username': os.getenv('KAFKA_API_KEY'),
    'sasl.password': os.getenv('KAFKA_API_SECRET'),
    'key.serializer': lambda v, c: v.encode('utf-8'),
}

producer_conf_order = {
    'bootstrap.servers': os.getenv('KAFKA_BOOTSTRAP'),
    'sasl.mechanism': 'PLAIN',
    'security.protocol': 'SASL_SSL',
    'sasl.username': os.getenv('KAFKA_API_KEY'),
    'sasl.password': os.getenv('KAFKA_API_SECRET'),
    'key.serializer': lambda v, c: v.encode('utf-8'),
}

# Schema Registry client and Protobuf serializer
sr_client = SchemaRegistryClient(schema_registry_conf)

protobuf_serializer_product = ProtobufSerializer(
    product_v2_pb2.Product,
    sr_client,
    {'auto.register.schemas': True}
)

protobuf_serializer_order = ProtobufSerializer(
    orders_v2_pb2.Order,
    sr_client,
    {'auto.register.schemas': True}
)

producer_conf_product['value.serializer'] = protobuf_serializer_product
producer_conf_order['value.serializer'] = protobuf_serializer_order

producer_product = SerializingProducer(producer_conf_product)
producer_order = SerializingProducer(producer_conf_order)

def delivery_report(err, msg):
    if err:
        print(f"Delivery failed: {err}")
    else:
        print(f"Produced to {msg.topic()} [{msg.partition()}] at offset {msg.offset()}")

categories = ["Electronics", "Books", "Clothing", "Toys", "Home"]
product_ids = []

def produce_product():
    prod = product_v2_pb2.Product(
        product_id=f"prod-{uuid.uuid4()}",
        name=f"Product-{random.randint(100,999)}",
        category=random.choice(categories),
        created_at=int(time.time() * 1000),
        description=faker.text(max_nb_chars=100)
    )
    producer_product.produce(
        topic="up_products",
        key=prod.product_id,
        value=prod,
        on_delivery=delivery_report
    )
    product_ids.append(prod.product_id)
    producer_product.poll(0)

def produce_order():
    order = orders_v2_pb2.Order(
        order_id=f"ord-{uuid.uuid4()}",
        product_id=random.choice(product_ids),
        quantity=random.randint(3, 100),
        order_timestamp=int(time.time() * 1000),
        unit_price=random.randint(1, 500)
    )
    producer_order.produce(
        topic="up_orders",
        key=order.order_id,
        value=order,
        on_delivery=delivery_report
    )
    producer_order.poll(0)

if __name__ == "__main__":
    while True:
        produce_product()
        time.sleep(1)
        produce_order()
