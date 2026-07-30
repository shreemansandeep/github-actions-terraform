"""
AWS Lambda Function Handler Sample

This is a simple, beginner-friendly AWS Lambda function written in Python.
"""

def lambda_handler(event, context):
    """
    The entry point for AWS Lambda service execution.
    
    :param event:   A Python dictionary containing data sent to the function when invoked 
                    (e.g., HTTP request payload, API Gateway data, S3 event, manual trigger).
    :param context: Provides runtime information (e.g., function name, request ID, 
                    time remaining before timeout).
    :return:        A dictionary response, typically structured for API Gateway or direct callers.
    """
    
    # 1. Extract inputs from the event payload (safely with fallback)
    name = "World"
    if isinstance(event, dict):
        name = event.get("name", "World")
    
    # 2. Perform simple logic
    greeting = f"Hello, {name}! Welcome to AWS Lambda."
    
    # 3. Print statement - AWS Lambda automatically captures standard print() 
    # output and logs it directly to AWS CloudWatch Logs.
    print(f"[INFO] Lambda executed successfully for user: {name}")
    
    # 4. Return standard HTTP/JSON response
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": {
            "message": greeting,
            "status": "success",
            "service": "AWS Lambda"
        }
    }


# Local testing block (Runs only when executing this script directly on your machine)
if __name__ == "__main__":
    sample_event = {"name": "Developer"}
    sample_context = None
    response = lambda_handler(sample_event, sample_context)
    print("Local Test Response:")
    print(response)
