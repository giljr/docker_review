# 🚀 Guia Completo: Docker Compose (MySQL + Node API + PHP)

Este guia mostra passo a passo como subir um ambiente full-stack usando Docker Compose com:

* MySQL
* API Node.js
* PHP (Apache)

---

# 📁 Estrutura do Projeto

```
proj_01/
├── api/
│   ├── src/
│   │   └── index.js
│   ├── db/
│   │   └── script.sql
│   └── package.json
├── website/
│   └── index.php
└── docker-compose.yml
```

---

# ⚙️ docker-compose.yml

```yaml
services:
  db:
    image: mysql:8.0
    container_name: mysql-container
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_ROOT_PASSWORD: jaythree
    volumes:
      - db-data:/var/lib/mysql
    restart: always

  api:
    image: node:18
    container_name: node-container
    working_dir: /home/node/app
    volumes:
      - ./api:/home/node/app
    command: sh -c "npm install && node src/index.js"
    ports:
      - "9001:9001"
    depends_on:
      - db

  web:
    image: php:8.2-apache
    container_name: php-container
    restart: always
    volumes:
      - ./website:/var/www/html
    ports:
      - "8888:80"
    depends_on:
      - db
      - api

volumes:
  db-data:
```

---

# 🧠 Passo 1 — Criar estrutura

```bash
mkdir proj_01 && cd proj_01
mkdir -p api/src api/db website
```

---

# 📦 Passo 2 — API Node

```bash
cd api
npm init -y
npm install express mysql
```

## 📄 src/index.js

```js
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
      console.log('MySQL não pronto, tentando novamente...')
      setTimeout(connectWithRetry, 3000)
    } else {
      console.log('Conectado ao MySQL')
    }
  })
}

connectWithRetry()

app.get('/products', (req, res) => {
  connection.query('SELECT * FROM products', (err, results) => {
    if (err) return res.status(500).json(err)
    res.json(results)
  })
})

app.listen(9001, '0.0.0.0', () => {
  console.log('API rodando na porta 9001')
})
```

---

# 🗄️ Passo 3 — Script SQL

## api/db/script.sql

```sql
CREATE DATABASE IF NOT EXISTS outfit_db;
USE outfit_db;

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sales_code INT NOT NULL,
    date DATE NOT NULL,
    store_id VARCHAR(255),
    product VARCHAR(255),
    qty INT NOT NULL,
    unit_price DECIMAL(10,2)
);

INSERT INTO products (sales_code, date, store_id, product, qty, unit_price) VALUES
(65014, '2019-01-12', 'Shopping Morumbi', 'Aster Pants', 5, 114),
(65014, '2019-01-12', 'Shopping Morumbi', 'Trench Coat', 1, 269),
(65016, '2019-01-12', 'Iguatemi Campinas', 'Peter Pan Collar', 2, 363);
```

---

# 🌐 Passo 4 — PHP

## website/index.php

```php
<?php
$result = file_get_contents("http://api:9001/products");
$products = json_decode($result);
?>

<table border="1">
<tr><th>Produto</th><th>Preço</th></tr>
<?php if ($products): ?>
<?php foreach($products as $p): ?>
<tr>
<td><?= $p->product ?></td>
<td><?= $p->unit_price ?></td>
</tr>
<?php endforeach; ?>
<?php endif; ?>
</table>
```

---

# 🚀 Passo 5 — Subir containers

```bash
docker compose down -v
docker compose up --build
```

---

# 🧪 Passo 6 — Popular banco

```bash
docker exec -i mysql-container mysql -uroot -pjaythree outfit_db < api/db/script.sql
```

---

# 🔎 Passo 7 — Testes

## API

```bash
curl http://localhost:9001/products
```

## Web

```
http://localhost:8888
```

---

# 🧠 Dicas importantes

* Nunca use `localhost` entre containers → use nome do serviço (`db`, `api`)
* Use volume Docker para MySQL (evita erro de permissão)
* Sempre reinicie após mudanças:

```bash
docker compose restart api
```

---

# 🏁 Resultado final

Você terá:

* API Node conectada ao MySQL
* PHP consumindo API
* Dados reais sendo exibidos

👉 Setup completo de ambiente full-stack com Docker 🚀
