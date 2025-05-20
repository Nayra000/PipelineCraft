const mongoose = require('mongoose');
const { MongoMemoryServer } = require('mongodb-memory-server');
const request = require('supertest');
const express = require('express');
const employeesRouter = require('../routes');

const app = express();
app.use(express.json());
app.use('/employees', employeesRouter);

let mongoServer;

beforeAll(async () => {
  mongoServer = await MongoMemoryServer.create();
  const uri = mongoServer.getUri();

  await mongoose.connect(uri);
});

afterAll(async () => {
  await mongoose.disconnect();
  await mongoServer.stop();
});

describe('Employees API', () => {
  test('should create a new employee', async () => {
    const response = await request(app)
      .post('/employees')
      .send({ name: 'nayra', position: 'manoura' });

    expect(response.status).toBe(201);
    expect(response.body.name).toBe('nayra');
  });

  test('should get all employees', async () => {
    const response = await request(app).get('/employees');
    expect(response.status).toBe(200);
    expect(Array.isArray(response.body)).toBe(true);
  });
});
