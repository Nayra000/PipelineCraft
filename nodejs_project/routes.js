const express = require('express');
const Employee = require('./model');
const router = express.Router();


router.post('/', async (req, res) => {
    const newEmp= new Employee(req.body);
    await newEmp.save();
    res.status(201).json(newEmp);
});


router.get('/', async (req, res) => {
    const employees = await Employee.find();
    res.json(employees);
});

module.exports = router;
