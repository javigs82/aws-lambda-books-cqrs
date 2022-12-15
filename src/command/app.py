import json


def handler(event, context):

    response = {
        "isBase64Encoded": False,
        "statusCode": 200,
        "headers": {"content-type": "application/json"},
        "body": "I am the Commander in charge of persistent operations"
    }
    return json.dumps(response)
