const mongoose = require('mongoose');

const EmployeeSchema = new mongoose.Schema({
    name: String,
    address: String
});

module.exports = mongoose.model('Employee', EmployeeSchema );
