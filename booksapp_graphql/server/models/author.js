const mongoose = require('mongoose')
const schema = mongoose.Schema

const autherSchema=new schema({
  name: String,
  age: String,
})

module.exports = mongoose.model('Author', autherSchema)
