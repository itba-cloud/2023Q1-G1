const AWS = require('aws-sdk');
const docClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context, callback) => {
// const dynamodb = AWS.DynamoDB({
//   endpoint: "${endpoint_dns}"
// })

  const tableName = 'inventory';
  
  const params = {
    TableName: tableName,
    Item: {
      'userId':  'unique-item-id',
      'itemId': 'value1',
      'timestamp': 123,
      'name': 'mouse'
      // add additional attributes as needed
    }
  }
  
    try {
    const result = await docClient.put(params).promise()
    console.log(`Successfully inserted item into ${tableName}: ${JSON.stringify(params.Item)}`);
  } catch (error) {
    console.error(`Error inserting item into ${tableName}: ${error}`);
    throw error;
  }


}