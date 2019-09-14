import base64
import json
import os
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])


def lambda_handler(event, context):
    dict = {}
    with table.batch_writer() as batch:
        for record in event['Records']:
            # Kinesis data is base64 encoded so decode here
            payload = base64.b64decode(record["kinesis"]["data"])
            payload_json = json.loads(payload)
            # parsing data into dictionary
            dict = {"y":payload_json["y"],"id":payload_json["id"],"is_hot":payload_json["is_hot"],"x":payload_json["x"]}
            #Writing into dynamodb in batch
            batch.put_item(Item=dict)
