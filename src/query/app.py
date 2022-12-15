import json


def handler(event, context):

    response = {
        "isBase64Encoded": False,
        "statusCode": 200,
        "headers": {"content-type": "application/json"},
        "body": "I am the Query in charge of return data"
    }
    return json.dumps(response)
