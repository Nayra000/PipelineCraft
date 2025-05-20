const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const employeesRouter = require('./routes');



dotenv.config();

const app = express();
app.use(express.json());


mongoose.connect(process.env.MONGO_URI).then(() => console.log('Connected to MongoDB'))
.catch(err => console.error(err));

app.get('/' ,(req ,res) =>{
    res.send("Hello from my simple app")
})
app.use('/employees', employeesRouter);

app.listen(3000,'0.0.0.0' ,() => console.log('Server running on port 3000'));
