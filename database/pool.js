const mysql = require('mysql')
const config = require('./config')

const pool = mysql.createPool({
  host: config.host,
  port: config.port,
  user: config.user,
  password: config.password,
  multipleStatements: config.multipleStatements,
  connectionLimit: config.connectionLimit
})

module.exports = pool