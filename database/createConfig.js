const mysql = require('mysql')
const config = require('./config.js')
const pool = mysql.createPool({
  host: config.host,
  port: config.port,
  user: config.user,
  password: config.password,
  multipleStatements: config.multipleStatements,
  connectionLimit: config.connectionLimit,
  database: config.database
})

module.exports = pool