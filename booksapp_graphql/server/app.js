const express = require('express')
const graphqlHTTP = require('express-graphql')
const schema = require('./schema/schema')
const mongoose = require('mongoose')
const cors = require('cors')

const app = express()

app.use(cors())

mongoose.connect('mongodb+srv://ranajit:ranajit@cluster0-yt2hx.mongodb.net/graphql?retryWrites=true&w=majority',   { useNewUrlParser: true })
mongoose.connection.once('open',()=>{
  console.log('DB is connnected');
})

app.use('/graphql', graphqlHTTP({schema, graphiql:true}))

app.listen(4000, ()=>{
  console.log("server started on 4000")
})
