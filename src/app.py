import json
import boto3
import uuid
import os

# Database k connection ka code
dynamodb = boto3.resource('dynamodb')
table_name = os.environ.get('TABLE_NAME', 'url-shortener-table')
table = dynamodb.Table(table_name)


cors_headers = {
    "Access-Control-Allow-Origin": "*", 
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
}

def lambda_handler(event, context):
    method = event.get('requestContext', {}).get('http', {}).get('method')
    path = event.get('rawPath', '/')

    
    if method == 'OPTIONS':
        return {
            'statusCode': 200, 
            'headers': cors_headers, 
            'body': ''
        }

    
    if method == 'POST':
        body = json.loads(event.get('body', '{}'))
        long_url = body.get('long_url')
        
        if not long_url:
            return {'statusCode': 400, 'headers': cors_headers, 'body': 'long_url missing hai!'}
            
        short_id = str(uuid.uuid4())[:6]
        table.put_item(Item={'short_id': short_id, 'long_url': long_url})
        
        domain = event.get('requestContext', {}).get('domainName', '')
        short_url = f"https://{domain}/{short_id}"
        
        return {
            'statusCode': 200,
            'headers': cors_headers, 
            'body': json.dumps({'short_url': short_url})
        }

    
    elif method == 'GET' and path != '/':
        short_id = path.strip('/')
        response = table.get_item(Key={'short_id': short_id})
        
        if 'Item' in response:
            return {
                'statusCode': 301,
                'headers': {'Location': response['Item']['long_url']} 
            }
        else:
            return {'statusCode': 404, 'headers': cors_headers, 'body': 'Link nahi mila!'}

    return {'statusCode': 400, 'headers': cors_headers, 'body': 'Kuch galat request aayi hai!'}