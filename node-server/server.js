const express = require('express');
const cors = require('cors');
const { BedrockRuntimeClient, InvokeModelCommand } = require('@aws-sdk/client-bedrock-runtime');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// Replace these values with your Bedrock region and model ID
const REGION = 'us-west-2';
const MODEL_ID = 'meta.llama3-8b-instruct-v1:0';

// Configure AWS SDK for Bedrock Runtime
const client = new BedrockRuntimeClient({ region: REGION });

// Middleware to parse JSON bodies
app.use(bodyParser.json());

app.use(cors());

// Define a simple route
app.get('/', (req, res) => {
  res.send('Hello, World!');
});

// Route to handle POST requests to /inference
app.post('/inference', async (req, res) => {
  console.log("Route hit");
  console.log("Request Body:", req.body);
  const userMessage = req.body.prompt;

  if (!userMessage) {
    return res.status(400).send({ error: 'Prompt is required' });
  }

  // Embed the message in Llama 3's prompt format
  const prompt = `
user
${userMessage}

assistant
`;

  // Format the request payload using the model's native structure
  const request = {
    prompt,
    max_gen_len: 50,  // Optional inference parameters
    temperature: 0,
    // top_p: 0.9,
  };

  try {
    // Encode and send the request
    const command = new InvokeModelCommand({
      contentType: 'application/json',
      body: JSON.stringify(request),
      accept: "application/json",
      modelId: MODEL_ID,
    });

    const randval = Math.floor(Math.random() * 3) + 1;
    let response1, response2;

    if (randval === 1) {
      const responseA = await client.send(command);
      const nativeResponseA = JSON.parse(Buffer.from(responseA.body).toString('utf8'));
      const responseTextA = nativeResponseA.generation;
      
      const responseB = await client.send(command);
      const nativeResponseB = JSON.parse(Buffer.from(responseB.body).toString('utf8'));
      const responseTextB = nativeResponseB.generation;

      response1 = responseTextA;
      response2 = responseTextB;

      res.send({ response1: responseTextA, response2: responseTextB });
    } else {
      const response = await client.send(command);
      const nativeResponse = JSON.parse(Buffer.from(response.body).toString('utf8'));
      const responseText = nativeResponse.generation;

      res.send({ response1: responseText });
    }
  } catch (err) {
    console.error(err, err.stack);
    res.status(500).send({ error: 'Error invoking Bedrock endpoint' });
  }
});

// Middleware for handling errors
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('There was an error, probably 0g\'s fault');
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
