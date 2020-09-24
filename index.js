const express = require('express')
const app = express()
const path = require('path')


app.set('secret', 'AC514182DC5C19FEB45F666E8FEE8F51')
app.set('path', './img/')
app.set('avartarPath', './profile/')
app.use('/uploads', express.static(__dirname + '/routes/client/profile'))
app.use('/products', express.static(__dirname + '/routes/client/products'))



//app.use(uploadConfig)
app.use(express.json())

app.use(require('cors')())

require('./routes/admin/index')(app)
require('./routes/client/index')(app)

const PORT = process.env.PORT || 5000
app.listen(PORT, () => {
  console.log(`App listen on ${PORT}`);
})
