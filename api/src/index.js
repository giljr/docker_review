const express = require('express')
const mysql = require('mysql')

const app = express()

let connection

function connectWithRetry() {
  connection = mysql.createConnection({
    host: 'db',
    user: 'root',
    password: 'jaythree',
    database: 'outfit_db'
  })

  connection.connect((err) => {
    if (err) {
      console.log('MySQL não pronto, tentando novamente em 3s...')
      setTimeout(connectWithRetry, 3000)
    } else {
      console.log('Conectado ao MySQL')
    }
  })
}

connectWithRetry()

app.get('/products', (req, res) => {
  if (!connection) {
    return res.status(500).json({ error: 'Sem conexão com banco' })
  }

  connection.query('SELECT * FROM products', (err, results) => {
    if (err) {
      console.error('Erro SQL:', err)
      return res.status(500).json({ error: err.message })
    }

    res.json(results)
  })
})

app.listen(9001, '0.0.0.0', () => {
  console.log('API rodando na porta 9001')
})