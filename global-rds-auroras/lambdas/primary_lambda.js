const AWS = require('aws-sdk');
const rdsDataService = new AWS.RDSDataService();

exports.handler = async (event) => {
  const params = {
    resourceArn: 'arn:aws:rds:eu-west-2:123456789012:cluster:primary-cluster-identifier', // replace with your primary cluster ARN
    secretArn: 'arn:aws:secretsmanager:eu-west-2:123456789012:secret:primary-db-credentials', // replace with your secret ARN for credentials
    sql: 'INSERT INTO your_table (column) VALUES (:value)',
    database: 'your_database_name',
    parameters: [{ name: 'value', value: { stringValue: 'your_value' } }],
    includeResultMetadata: false
  };

  try {
    const result = await rdsDataService.executeStatement(params).promise();
    return {
      statusCode: 200,
      body: JSON.stringify(result),
    };
  } catch (err) {
    console.error(err);
    return {
      statusCode: 500,
      body: JSON.stringify(err),
    };
  }
};
