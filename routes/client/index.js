const pool = require('../../database/createConfig')

module.exports = (app) => {
  const bcrypt = require('bcrypt')

  const multer = require('multer')
  const fs = require('fs')
  // const storage = multer.diskStorage({
  //   destination: function (req, file, cb) {
  //     cb(null, 'routes/client/profile')
  //   },
  //   filename: function (req, file, cb) {
  //     cb(null, Date.now() + '-' + file.originalname)
  //   }

  // })
  const uploadConfig = multer({
    //帮你建一个upload的资料夹
    dest: './routes/client/profile'
  })
  const productConfig = multer({
    dest: './routes/client/products'
  })
  const getAvatar = img => {
    if (img == "") return ''
    return `http://localhost:5000/uploads/${img}`
  }
  const getProduct = img => {
    if (img == "") return ''
    return `http://localhost:5000/products/${img}`
  }

  const saltRounds = 10;
  const jwt = require('jsonwebtoken')
  // const multer = require('multer')

  const express = require('express')
  const router = express.Router()

  // const storage = multer.diskStorage({
  //   destination: function (req, file, cb) {
  //     cb(null, 'routes/admin/img')
  //   },
  //   filename: function (req, file, cb) {
  //     cb(null, Date.now() + '-' + file.originalname)
  //   }

  // })
  // const uplaod = multer({ storage: storage }).array('file')

  app.use('/client/api', router)
  //get gender 
  router.get('/register/gender', async (req, res) => {
    const sql = 'SELECT G_NAME,G_ID FROM gender'
    await pool.query(sql, (err, result) => {
      if (err) return res.status(422).json({ err })
      return res.status(200).json({ result })

    })
  })
  //get country
  router.get('/register/country', async (req, res) => {
    const sql = 'SELECT C_NAME,C_ID FROM country'
    await pool.query(sql, (err, result) => {
      if (err) return res.status(422).json({ err })
      return res.status(200).json({ result })
    })
  })
  //get region
  router.get('/register/region/:id', async (req, res) => {
    const id = req.params.id;
    const sql = 'SELECT C_ID FROM country WHERE C_NAME=?'
    const params = [id];
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json({ err })
      const id = result[0].C_ID
      const sql = 'SELECT R_NAME,R_ID FROM region WHERE C_ID=?'
      const params = [id]
      pool.query(sql, params, (err, result) => {
        if (err) return res.status(422).json({ err })
        return res.status(200).json(result)

      })

    })

  })
  //post register
  router.post('/register/register', async (req, res) => {

    const form = req.body.form

    const uID = req.body.form.name
    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    const params = [uID]
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json({ err })

      if (result.length > 0) {
        //acount duplicate 
        return res.status(422).json(
          {
            result,
            msg: 'Duplicate Account'
          }
        )
      } else {

        const sql = 'SELECT c.C_ID,r.R_ID FROM country c JOIN region r ON c.C_ID = R.C_ID WHERE c.C_NAME= ? AND r.R_NAME=?'
        const params = [form.country, form.region]
        pool.query(sql, params, (err, result) => {

          if (err) return res.status(422).json(err)
          if (result.length > 0) {

            form.country = result[0].C_ID;
            form.region = result[0].R_ID;
            const pass = form.password;
            const hash = bcrypt.hashSync(pass, saltRounds)
            form.password = hash
            const params = []
            const sql = 'INSERT INTO user(UserID,UserPass,U_Gender,U_Email,PhoneNum,U_Country,U_Region) values(?,?,?,?,?,?,?)'
            const formArr = Object.keys(form)

            for (let i = 0; i < formArr.length; i++) {
              params.push(form[formArr[i]])
            }
            console.log(params);
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(422).json({ err })
              return res.status(200).json(result)
            })
          }
        })



      }
    })
  })
  //post login
  router.post('/login', async (req, res) => {
    const { name, password } = req.body.form
    const params = [name]
    const sql = 'SELECT UserID,UserPass,U_avatar FROM user WHERE UserID=?'

    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json({ err })
      if (result.length > 0) {
        const hash = result[0].UserPass
        const isValid = bcrypt.compareSync(password, hash)
        if (!isValid) {
          res.status(422).json({
            msg: 'Invalid password'
          })
        }
        const token = jwt.sign({
          name
        }, app.get('secret'))
        const url = getAvatar(result[0].U_avatar)

        return res.status(200).json({
          token,
          name,
          url
        })
      }
      return res.status(422).json({
        msg: 'No this Account'
      })
    })
  })

  //avatar upload
  router.put('/profile/avatar/upload', uploadConfig.single('file'), async (req, res) => {

    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    console.log(name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const sql = "SELECT U_avatar FROM user WHERE UserID=?"
        const params = [name]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          if (result.length > 0) {
            if (result[0].U_avatar !== "") {
              console.log('true');
              const delAva = "./routes/client/profile/" + result[0].U_avatar
              console.log(delAva);
              fs.unlinkSync(delAva);
            }
            const file = req.file;
            const fn = Date.now() + tokenData.name + file.originalname
            fs.renameSync(file.path, './routes/client/profile/' + fn)
            file.url = getAvatar(fn)
            const sql = "UPDATE user SET U_avatar = ? WHERE UserID=? "
            const params = [fn, name]
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(422).json({ err })
              return res.status(200).json(file)
            })
          }

        })


      }
    })




  })
  router.get('/profile/avatar', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {

        const sql = 'SELECT U_avatar,UserID from user WHERE UserID=?'
        const params = [name]
        console.log(params);
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          const url = getAvatar(result[0].U_avatar)
          const name = result[0].UserID
          return res.status(200).json({ url, name })

        })

      }
    })

  })

  //get avatar
  router.get('/profile/avatar/get/:id', async (req, res) => {

    const sql = 'SELECT U_avatar,UserID from user WHERE UserID=?'
    const params = [req.params.id]
    console.log(params);
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json({ err })
      const url = getAvatar(result[0].U_avatar)
      const name = result[0].UserID
      return res.status(200).json({ url, name })

    })

  })

  router.get('/profile/info/setting', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);


    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {

        const sql = "SELECT UserID,U_Email,BIO,PhoneNum,U_Gender,U_FirstName,U_LastName,U_Country,U_Region FROM user WHERE UserID=?"
        const params = [name]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          if (result.length > 0) {
            console.log(result);
            const data = result[0]
            const country = result[0].U_Country
            const region = result[0].U_Region
            const sql = "SELECT C_NAME FROM country WHERE C_ID=?"
            const params = [country]
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(422).json({ err })
              if (result.length > 0) {
                data.U_Country = result[0].C_NAME
                const sql = "SELECT R_NAME FROM region WHERE R_ID=?"
                const params = [region]
                pool.query(sql, params, (err, result) => {
                  if (err) return res.status(422).json({ err })
                  if (result.length > 0) {
                    data.U_Region = result[0].R_NAME
                    console.log(data);
                    return res.status(200).json({ data })
                  }
                })
              }
            })

          }

        })

      }
    })

  })

  // getinfo
  router.get('/profile/info/:id', async (req, res) => {

    const id = req.params.id;
    const sql = "SELECT UserID,U_Email,BIO,PhoneNum,U_Gender,U_FirstName,U_LastName,U_Country,U_Region FROM user WHERE UserID=?"
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json({ err })
      if (result.length > 0) {
        console.log(result);
        const data = result[0]
        const country = result[0].U_Country
        const region = result[0].U_Region
        const sql = "SELECT C_NAME FROM country WHERE C_ID=?"
        const params = [country]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          if (result.length > 0) {
            data.U_Country = result[0].C_NAME
            const sql = "SELECT R_NAME FROM region WHERE R_ID=?"
            const params = [region]
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(422).json({ err })
              if (result.length > 0) {
                data.U_Region = result[0].R_NAME
                console.log(data);
                return res.status(200).json({ data })
              }
            })
          }
        })

      }

    })
  })

  //check username
  router.get('/profile/username/:id', async (req, res) => {
    const name = req.params.id;
    const sql = "SELECT UserID FROM user WHERE UserID=?"
    const params = [name]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      return res.status(200).json({ result })

    })
  })

  //update info 
  router.post('/profile/update', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const { bio, country, email, first, gender, last, phone, region, username } = req.body.form;
        // console.log(bio, country, email, first, gender, last, phone, region, username);
        const sql = "UPDATE user SET BIO=?,U_Country=?,U_Email=?,U_FirstName=?,U_LastName=?,U_Gender=?,PhoneNum=?,U_Region=? WHERE UserID=?"
        const params = [bio, country, email, first, last, gender, phone, region, username]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          res.status(200).json({ result })
        })

      }
    })


  })

  //change pass
  router.post('/profile/changepass', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        console.log(req.body.change);
        const pass = req.body.change.currPass
        const newPass = req.body.change.newPass
        console.log(pass);
        const sql = "SELECT UserPass FROM user WHERE UserID=?"
        const params = [name]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          if (result.length > 0) {
            const hash = result[0].UserPass
            const isValid = bcrypt.compareSync(pass, hash)
            console.log(isValid);
            if (!isValid) {
              return res.status(404).json({
                msg: 'Invalid password'
              })
            }

            const sql = "UPDATE user SET UserPass=? WHERE UserID=?"
            const newHash = bcrypt.hashSync(newPass, saltRounds)
            const params = [newHash, name]
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(422).json({ err })
              return res.status(200).json({ result, msg: "Change Success" })
            })

          }
        })

      }
    })
  })


  //get categories
  router.get('/categories', async (req, res) => {
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

  })

  //get sub categories
  router.get('/subcategories/:id', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const id = req.params.id;
        const sql = "SELECT Sub_ID,Sub_Name FROM subcategories WHERE C_ID=?"
        const params = [id]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          return res.status(200).json({ result })

        })

      }
    })
  })

  //get uploader img
  router.get('/uploader/image/:id', async (req, res) => {
    const sql = "SELECT U_Avatar FROM user WHERE UserID=?"
    const id = req.params.id
    const params = -[id]
    pool.query(sql, id, (err, result) => {
      if (err) return res.status(404).json({ err })
      if (result.length > 0) {
        const url = getAvatar(result[0].U_Avatar)
        console.log(url);
        return res.status(200).json({ url })
      }

    })
  })


  //get edit product 
  router.get('/product/edit/:id', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const id = req.params.id;
        const sql = "SELECT P_ID, P_Category,P_Sub,P_Title,P_Price,P_Description,P_Deal FROM product WHERE P_ID=? AND P_STATUS=2"
        const params = [id]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(422).json({ err })
          return res.status(200).json({ result })

        })

      }
    })

  })


  //get product index
  router.get('/findCategory/:id', async (req, res) => {

    const sql = "SELECT C_ID FROM categories WHERE C_Name=?"
    const id = req.params.id;
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      if (result.length > 0) {
        const cID = result[0].C_ID;
        const sql = 'SELECT P_ID, P_Title,P_Price,P_Description,UploadBy,P_Upload FROM product WHERE P_Category=? AND P_Status=2';
        const params = [cID]
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(404).json({ err })

          if (result.length > 0) {
            return res.status(200).json(result)
          }
        })
      }
    })

  })
  // get product img
  router.get('/productimg/:id', async (req, res) => {
    const id = req.params.id
    const sql = "SELECT IMG_ADDRESS FROM productimage WHERE P_ID=?"
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      const url = getProduct(result[0].IMG_ADDRESS);

      return res.status(200).json({ url })
    })
  })

  //upload product 
  router.post('/product/upload/meetup', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {

        const address = req.body.address;
        const deliveryDes = req.body.deliveryDes;
        console.log(address, deliveryDes);
        const sql = "INSERT INTO meetup(M_ADD) VALUES(?)";
        const params = [address]
        const deals = {}
        pool.query(sql, params, (err, result) => {
          if (err) return res.status(404).json({ err })
          deals.meet = result.insertId
          const sql = "INSERT INTO pos(P_DES) VALUES(?)";
          const params = [deliveryDes];
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err });
            deals.pos = result.insertId;
            const sql = "INSERT INTO deals(D_MEETUP,D_POS) VALUES(?,?)";
            const params = [deals.meet, deals.pos]
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(404).json({ err })
              const meetID = result.insertId;
              return res.status(200).json({ meetID })

            })
          })
        })
      }
    })

  })
  //upload info
  router.post('/product/upload/info', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const upload = req.body.upload
        console.log(upload);
        console.log(upload.sub === "");

        if (upload.sub === "") {
          const sql = "INSERT INTO product(P_Title,P_Price,P_Description,P_Deal,UploadBy,P_Category) Values(?,?,?,?,?,?)";
          const params = [upload.name, upload.price, upload.des, upload.meetID, name, upload.category];
          parseInt
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err })
            const pID = result.insertId;
            return res.status(200).json({ pID })

          })
        } else {
          const sql = "INSERT INTO product(P_Title,P_Price,P_Description,P_Deal,UploadBy,P_Category,P_Sub) Values(?,?,?,?,?,?,?)";
          const params = [upload.name, upload.price, upload.des, upload.meetID, name, upload.category, upload.sub];
          parseInt
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err })
            const pID = result.insertId;
            return res.status(200).json({ pID })

          })

        }

      }
    })


  })

  router.post('/product/update/info/:id', async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'

    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const upload = req.body.upload
        console.log(upload);
        console.log(upload.sub === "");

        if (upload.sub === "") {
          // const sql = "INSERT INTO product(P_Title,P_Price,P_Description,P_Deal,UploadBy,P_Category) Values(?,?,?,?,?,?)";
          const sql = "UPDATE product SET P_Title = ?, P_Price = ? , P_Description = ?, P_Deal = ?,UploadBy = ? ,P_Category = ? WHERE P_ID=? "
          const params = [upload.name, upload.price, upload.des, upload.meetID, name, upload.category, req.params.id];
          parseInt
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err })
            const pID = result.insertId;
            return res.status(200).json({ pID })

          })
        } else {
          const sql = "INSERT INTO product(P_Title,P_Price,P_Description,P_Deal,UploadBy,P_Category,P_Sub) Values(?,?,?,?,?,?,?)";
          const params = [upload.name, upload.price, upload.des, upload.meetID, name, upload.category, upload.sub];
          parseInt
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err })
            const pID = result.insertId;
            return res.status(200).json({ pID })

          })

        }

      }
    })


  })
  //uplaod images
  router.post('/product/upload/img/:id', productConfig.array('file'), async (req, res) => {
    const token = String(req.headers.authorization || '').split(' ').pop()
    const tokenData = jwt.verify(token, app.get('secret'))
    const name = tokenData.name
    const params = [name]
    //console.log(tokenData.name);

    const sql = 'SELECT UserID FROM user WHERE UserID=?'
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(422).json(err)

      if (result.length > 0) {
        const id = req.params.id
        const files = req.files;
        for (let i = 0; i < files.length; i++) {
          const fn = Date.now() + name + files[i].originalname
          fs.renameSync(files[i].path, './routes/client/products/' + fn)
          files[i].url = getAvatar(fn)
          const sql = "INSERT INTO productimage(IMG_ADDRESS,P_ID) VALUES(?,?)";
          const params = [fn, id]
          pool.query(sql, params, (err, result) => {
            if (err) return res.status(404).json({ err })
            res.end();

          })
        }

      }
    })

  })

  //search
  router.get('/user/search', async (req, res) => {
    const type = req.query.type;
    const keyword = req.query.query
    if (type.toUpperCase() === "ITEM") {

      //search item
      const sql = "SELECT * FROM product WHERE P_Title LIKE ? AND P_STATUS = 2 AND P_BLOCKED = 0"
      const params = []
      params.push("%" + keyword + "%")

      pool.query(sql, params, (err, result) => {
        if (err) return res.status({ err })
        return res.status(200).json({ result })

      })
    } else {
      //search user
      const sql = "SELECT UserID,U_avatar FROM user WHERE UserID=?";
      const params = [keyword]
      await pool.query(sql, params, (err, result) => {
        if (err) return res.status(422).json({ err })
        if (result.length > 0) {
          const url = getAvatar(result[0].U_avatar)
          const name = result[0].UserID
          return res.status(200).json({ result, url, name })
        }
        return res.status(200).json({
          result
        })
      })
    }

  })

  //get sub 
  router.get('/sublist/:id', async (req, res) => {
    const id = req.params.id;

    const sql = "SELECT C_ID FROM categories WHERE C_Name=?"
    // const sql = "SELECT Sub_ID,Sub_Name FROM C_ID FROM subcategories WHERE C_ID=?"
    const params = [id];
    await pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })

      const cID = result[0].C_ID
      console.log(cID);

      const sql = "SELECT Sub_ID,Sub_Name FROM subcategories WHERE C_ID=?"
      const params = [cID]
      pool.query(sql, params, (errr, result) => {
        if (err) return res.status(404).json({ err })

        return res.status(200).json({ result })
      })
    })
  })

  //find sub product 
  router.get('/findsub/:name', async (req, res) => {

    const sql = "SELECT P_ID, P_Title,P_Price,P_Description,UploadBy FROM product WHERE P_Sub=? AND P_Status=2"
    const params = [req.params.name]
    console.log(params);
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      return res.status(200).json({ result })

    })

  })

  //get product
  router.get('/product/info/:id', async (req, res) => {
    const id = req.params.id;
    const sql = "SELECT P_Title,P_Price,P_Description,P_Upload,P_Deal,UploadBy,P_Category,P_Sub ,P_Active FROM product WHERE P_Status = 2 AND P_BLOCKED = 0 AND P_ID=?"
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      return res.status(200).json({ result })

    })
  })
  router.get('/product/info/img/:id', async (req, res) => {
    const sql = "SELECT IMG_ADDRESS FROM productimage WHERE P_ID=?";
    const id = req.params.id;
    pool.query(sql, id, (err, result) => {
      if (err) return res.status(200).json({ err })
      //  const url = getProduct(result[0].IMG_ADDRESS)
      const list = [];
      for (let i = 0; i < result.length; i++) {
        list.push(getProduct(result[i].IMG_ADDRESS));
      }
      return res.status(200).json({ list })

    })
  })

  router.get('/product/address/:id', (req, res) => {
    const sql = "SELECT M.M_ADD,P.P_DES FROM deals d JOIN meetup m ON d.D_MEETUP = m.M_ID JOIN pos p ON d.D_POS = P.P_ID WHERE D.D_ID = ?"
    const params = [req.params.id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(200).json({ err })

      return res.status(200).json({ result })

    })

  })


  //del product 
  router.post('/del/product/:id', (req, res) => {
    const id = req.params.id;
    const sql = "SELECT P_ID FROM orders WHERE P_ID=? AND O_STATUS = 1"
    pool.query(sql, [id], (err, result) => {
      if (err) return res.status(404).json({ err })
      // console.log(result);
      if (result.length > 0) {

      } else {

        const sql = "SELECT *  FROM product WHERE P_ID=? AND P_Active = 1"
        const params = [id]
        console.log(params);

        pool.query(sql, params, (err, result) => {
          if (err) return res.status(404).json({ err })
          if (result.length > 0) {
            const sql = "DELETE FROM productimage WHERE P_ID=?"
            const params = [id]
            pool.query(sql, params, (err, result) => {
              if (err) return res.status(404).json({ err })
              console.log(result);
              const sql = "DELETE FROM product WHERE P_ID=?"
              const params = [id]
              pool.query(sql, params, (err, result) => {
                if (err) return res.status(404).json({ err })
                return res.status(200).json({ result })

              })

            })
          }
        })
      }

    })

  })

  //insert order
  router.post('/orders', async (req, res) => {
    console.log(req.body.details);
    const { id, buyer, seller, price } = req.body.details;
    const sql = "INSERT INTO orders(BUYER,SELLER,P_ID,P_PRICE) VALUES (?,?,?,?)";
    const params = [buyer, seller, id, price]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      const sql = "UPDATE product SET P_Active = 0 WHERE P_ID=?"
      const params = [id]
      pool.query(sql, params, (err, result) => {
        if (err) return res.status(404).json({ err })
        return res.status(200).json({ result })

      })
      // return res.status(200).json({ err })

    })

  })

  //comfirm order
  router.get('/orders/:id', async (req, res) => {
    const id = req.params.id;
    const sql = "SELECT SELLER,P_ID,O_DATE,O_ID FROM orders WHERE BUYER=? AND O_STATUS=1"
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json([err])
      return res.status(200).json({ result })

    })

  })

  //evaluate
  router.post('/evaluate', async (req, res) => {
    const evaluate = req.body.evaluate
    console.log(evaluate);
    const sql = "INSERT INTO evaluate(E_RATING,E_GIVER,E_RECEIVER,P_ID,E_COMMENT) VALUES (?,?,?,?,?)"
    const params = [evaluate.rate, evaluate.buyer, evaluate.seller, evaluate.id, evaluate.feedback]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      const sql = "UPDATE orders SET O_STATUS = 0 WHERE P_ID=?"
      const params = [evaluate.id]
      pool.query(sql, params, (err, result) => {
        if (err) return res.status(404).json({ err })
        return res.status(200).json({ result })



      })
    })
  })
  //get rating 
  router.get('/getRating/:id', async (req, res) => {
    const id = req.params.id;
    const sql = "SELECT E_RATING,E_COMMENT,E_GIVER,RATE_DATE FROM evaluate WHERE E_RECEIVER=?"
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      return res.status(200).json({ result })
    })
  })
  router.get('/product/get/all/:id', async (req, res) => {
    const id = req.params.id;
    const sql = "SELECT * FROM product WHERE UploadBy = ? AND P_Status =2"
    const params = [id]
    pool.query(sql, params, (err, result) => {
      if (err) return res.status(404).json({ err })
      return res.status(200).json({ result })

    })
  })

}
