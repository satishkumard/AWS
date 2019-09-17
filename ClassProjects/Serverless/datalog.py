import base64
import json


def lambda_handler(event, context):
    for record in event['Records']:
        # Kinesis data is base64 encoded so decode here
        payload = base64.b64decode(record["kinesis"]["data"])
        payload_json = json.loads(payload)
        print("Decoded payload: " + 'id: ' +  payload_json['id'] + 'x: ' + payload_json['x'] + 'y: ' + payload_json['y'])
