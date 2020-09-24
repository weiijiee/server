const pool = require('../../database/createConfig')

module.exports = (app) => {

  const getProduct = img => {
    if (img == "") return ''
    return `http://localhost:5000/products/${img}`
  }

  const express = require('express')
  const bcrypt = require('bcrypt')
  const saltRounds = 10;
  const jwt = require('jsonwebtoken')
  const multer = require('multer')
  const router = express.Router()
  const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'routes/admin/img')
    },
    filename: function (req, file, cb) {
      cb(null, Date.now() + '-' + file.originalname)
    }

  })
  const uplaod = multer({ storage: storage }).array('file')

  app.use('/admin/api', router)

  router.post('/upload', async (req, res) => {
    uplaod(req, res, function (err) {

      if (err instanceof multer.MulterError) {
        return res.status(500).json(err)
      } else if (err) {
        return res.status(500).json(err)
      }
      const filenames = []
      for (let i = 0; i < req.files.length; i++) {
        filenames.push(app.get('path') + req.files[i].filename)
      }
      console.log(filenames);



      return res.status(200).send(req.file)

    })
  })

  router.get('/personal', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })

      if (result.length > 0) {
        return res.status(200).json({
          result
        })

      }
    })

  })
  router.post('/categories', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const data = req.body.name
        const sql = 'INSERT INTO categories(C_Name) values (?)'
        const params = [data]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err,
              msg: 'Insert faild'
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })


      }
    })


  })

  router.get('/categories', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))

    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const sql = 'SELECT C_Name,C_ID FROM categories '
        pool.query(sql, (err, result) => {
          if (err) {
            return res.status(404).json({ err })
          } else {
            return res.status(200).json({
              result
            })
          }
        })

      } else {
        return res.status(401).json({ msg: 'Invalid Account' })
      }



    })

  })

  router.get('/categories/:id', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {



      if (result.length > 0) {
        const parentID = req.params.id
        const sql = 'SELECT C_ID FROM categories where C_Name=?'
        const params = [parentID]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.json(err)
          } else {
            return res.json({
              result
            })
          }
        })


      }



    })



  })
  router.post('/categories/:id', async (req, res) => {


    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {



      if (result.length > 0) {
        const id = req.params.id
        const name = req.body.name
        const sql = 'INSERT INTO subcategories(Sub_Name,C_ID) values (?,?)'
        const params = [name, id]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(404).json({ err })
          return res.status(200).json({ result })
        })
      }



    })



  })
  router.put('/categories/:id', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {



      if (result.length > 0) {
        const id = req.params.id
        const name = req.body.name
        const sql = 'UPDATE categories SET C_Name=? WHERE C_ID=?'
        const params = [name, id]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })
      }



    })



  })
  router.get('/categories/sub/:id', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const id = req.params.id;
        const sql = 'SELECT COUNT(Sub_Name) AS Total FROM `subcategories` WHERE C_ID = ? '
        const params = [id]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })
      }



    })
  })

  router.delete('/categories/:id', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const id = req.params.id
        // console.log(id);
        const sql = 'DELETE FROM categories WHERE C_Name=?'
        const params = [id]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            res.status(200).json({ result })

          }
        })

      } else {
        if (result.length === 0) {
          return res.status(422).json({
            msg: 'No this Account!!'
          })
            ;
        }
      }
    })
  })







  router.get('/sub', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const sql = 'SELECT s.Sub_Name, c.C_Name,s.Sub_ID ,c.C_ID  FROM subcategories s LEFT JOIN categories c ON s.C_ID = c.C_ID'
        pool.query(sql, (err, result) => {
          if (err) {
            return res.status(404).json({ err })
          } else {
            console.log(result);
            return res.status(200).json({
              result

            })
          }
        })

      }
    })

  })
  router.put('/sub', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {

        const id = req.body.category
        const sub = req.body.sub
        const sID = req.body.subIndex
        //console.log(sub, id, sID);
        const sql = 'UPDATE subcategories SET C_ID=?,Sub_Name=? WHERE Sub_ID=?'
        const params = [id, sub, sID]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })

      }
    })




  })

  router.delete('/sub', async (req, res) => {


    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {


        const id = req.body.id;
        const sql = 'DELETE FROM subcategories WHERE Sub_ID= ?'
        const params = [id]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })


      }
    })




  })

  //admin 
  // router.get('/test', async (req, res) => {
  //   const pass = 'Loh123456'
  //   const password = bcrypt.hashSync(pass, saltRounds);
  //   const compare = bcrypt.compareSync(pass, password)
  //   res.json({
  //     password,
  //     compare
  //   })
  // })
  router.post('/register', async (req, res) => {




    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {


        const id = req.body.id
        const name = req.body.name
        const pass = req.body.password
        const password = bcrypt.hashSync(pass, saltRounds);
        //const valid = bcrypt.compareSync(pass, password)
        // console.log(id, name, password);
        // console.log(valid);
        const sql = 'INSERT INTO admin(A_ID,A_NAME,A_PASS) values (?,?,?)'
        const params = [id, name, password]
        pool.query(sql, params, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })

      }
    })



    // const pass = '123456'
    // const scret = bcryt.hashSync(pass, 10);
    // console.log(scret);
    //console.log(bcryt.compareSync(pass, scret))

  })
  router.get('/admininfo', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {

        const sql = 'SELECT A_ID, A_Name FROM admin'
        pool.query(sql, (err, result) => {
          if (err) {
            return res.status(404).json({
              err
            })
          } else {
            return res.status(200).json({
              result
            })
          }
        })


      }
    })





  })



  router.post('/login', async (req, res) => {
    const { name, password } = req.body
    const param = []
    param.push(name)
    const sql = 'SELECT A_ID,A_PASS FROM admin WHERE A_ID=?'
    pool.query(sql, param, (err, result) => {
      if (err) {
        res.status(404).json({
          err
        })
      } else {

        if (result.length === 0) {
          return res.status(422).json({
            msg: 'No this Account!!'
          })
            ;
        }
        const hash = result[0].A_PASS;
        const id = result[0].A_ID

        const isValid = bcrypt.compareSync(password, hash)
        if (!isValid) {
          return res.status(422).json({
            msg: 'password wrong'
          })
        }
        console.log("true");

        const token = jwt.sign({
          id
        }, app.get('secret'))

        res.status(200).json({ token })

      }
    })

  })

  //approved or rejected product
  router.put('/product/check', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const name = tokenData.id
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        console.log(name);
        const sql = "UPDATE product SET P_Status=?, ApprovedBy=? WHERE P_ID=?";
        const params = [req.body.status, name, req.body.pId]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(404).json({ err })
          return res.status(200).json({ result })

        })


      }
    })

  })

  //get product info
  router.get('/product/info', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const sql = "SELECT P_ID,P_Title,P_Price,P_Description,P_Upload,P_Deal,UploadBy,P_Category,P_Sub FROM product WHERE P_Status = 1 AND P_Active = 1";
        pool.query(sql, (err, result) => {
          if (err) return res.status(404).json({ err })
          return res.status(200).json({ result })

        })


      }
    })
  })

  //get product image
  router.get('/product/image/:id', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    await pool.query(sql, params, (err, result) => {

      if (result.length > 0) {

        const sql = "SELECT IMG_ADDRESS FROM productimage WHERE P_ID=?";
        const id = req.params.id;
        pool.query(sql, id, (err, result) => {
          if (err) return res.status(200).json({ err })
          const url = getProduct(result[0].IMG_ADDRESS)
          const list = [];
          for (let i = 0; i < result.length; i++) {
            list.push(getProduct(result[i].IMG_ADDRESS));
          }
          return res.status(200).json({ url, list })

        })
      }
    })
  })

  //get product address
  router.get('/product/address/:id', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    await pool.query(sql, params, (err, result) => {

      if (result.length > 0) {
        const sql = "SELECT M.M_ADD,P.P_DES FROM deals d JOIN meetup m ON d.D_MEETUP = m.M_ID JOIN pos p ON d.D_POS = P.P_ID WHERE D.D_ID = ?"
        const params = [req.params.id]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(200).json({ err })

          return res.status(200).json({ result })

        })


      }
    })
  })

  //get product categoreis
  router.get('/product/categories/:id', async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const params = [tokenData.id]
    const sql = 'SELECT A_ID,A_NAME FROM admin WHERE A_ID=?'
    await pool.query(sql, params, (err, result) => {

      if (result.length > 0) {

        const sql = "SELECT * FROM categories WHERE C_ID=?"
        const params = [req.params.id]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(404).json({ err })

          const cName = result[0].C_Name

          const sql = "SELECT Sub_Name FROM subcategories WHERE Sub_ID=?"
          const params = [result[0].C_ID]
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err })
            let sName = ""
            if (result.length > 0) {
              sName = result[0].Sub_Name
            }
            return res.status(200).json({ cName, sName })
          })
        })
      }
    })

  })


}
