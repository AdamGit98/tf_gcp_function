"""aws wrapper for six degrees of kevin bacon"""
# pylint: disable=import-error, line-too-long, unused-argument
from kb import KevinBacon


def lambda_handler(event, context):
    """main function for the AWS function"""
    my_sd = KevinBacon('/wiki/Six_Degrees_of_Kevin_Bacon')
    my_sd.six_degrees()
    return {
        'statusCode': 200,
        'body': my_sd.as_json()
    }


# Entry point for local execution
if __name__ == "__main__":
    lambda_handler({}, {})
