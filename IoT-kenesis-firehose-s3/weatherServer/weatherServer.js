const AWS = require('aws-sdk');
const kinesis = new AWS.Kinesis({ region: 'us-east-1' });

const streamName = 'ExampleDataStream';
let intervalInMilliseconds = 10000; // Default interval set to 10 seconds

// Function to generate random weather data
function generateWeatherData() {
  const cities = ['Philadephia', 'New York', 'California', 'New Orleans'];
  const city = cities[Math.floor(Math.random() * cities.length)];
  const temperature = (Math.random() * 30).toFixed(2); // Generates a random temperature between 0 and 30
  const humidity = (Math.random() * 100).toFixed(2); // Generates a random humidity percentage

  return {
    city,
    temperature: `${temperature}C`,
    humidity: `${humidity}%`,
    timestamp: new Date().toISOString(),
  };
}

// Function to send data to Kinesis
function sendDataToKinesis() {
  const data = generateWeatherData();
  const params = {
    Data: JSON.stringify(data), // Data must be a string
    PartitionKey: data.city, // Using city as the partition key
    StreamName: streamName,
  };

  kinesis.putRecord(params, (err, data) => {
    if (err) {
      console.error('Error sending data to Kinesis:', err);
    } else {
        console.log(data)
      console.log('Successfully sent data to Kinesis:', params.Data);
    }
  });
}

// Configurable interval for sending data
function startDataGeneration(interval) {
  intervalInMilliseconds = interval || intervalInMilliseconds;
  setInterval(sendDataToKinesis, intervalInMilliseconds);
  console.log(`Starting data generation, sending data every ${intervalInMilliseconds / 1000} seconds...`);
}

// Start generating weather data
startDataGeneration(5000); // Configure the interval as needed, e.g., 5000 milliseconds for 5 seconds
