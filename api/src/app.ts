import express from "express";
import http from "http";

const app = express();
const PORT = process.env.PORT || 9000;

const server = http.createServer(app);

// Middleware to parse JSON
app.use(express.json());

// Simple GET route
app.get('/', (req: express.Request, res: express.Response) => {
  res.send("Hello, Express with TypeScript!");
});

// Start the server
server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});