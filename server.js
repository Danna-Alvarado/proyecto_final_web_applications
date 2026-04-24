const express = require("express");
const cors = require("cors");
const session = require("express-session");
const mysql = require("mysql2");

const app = express();

app.use(cors());

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

//MANEJO DE  SESIONES
app.use(session({
  secret: "secreto",
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: false,
    httpOnly: true
  }
}));

app.use(express.static("public"));


//MIDDLEWARE DE PROTECCIÓN
function verificarSesion(req, res, next) {

  if (req.session && req.session.user) {
    next();
  } else {
    console.log("Access blocked");
    res.redirect("/");
  }
}

//BASE DE DATOS
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "album_store"
});

db.connect(err => {
  if (err) {
    console.error("Error de conexión:", err);
  } else {
    console.log("Conexion exitosa");
  }
});


//SERVIDOR
app.listen(3000, () => {
  console.log("Servidor corriendo en http://localhost:3000");
});


//LOGIN 
app.get("/", (req, res) => {
  if (req.session.user) {
    return res.redirect("/dashboard");
  }
  res.sendFile(__dirname + "/public/login.html");
});
//REGISTRO
app.get("/register", (req, res) => {
  res.sendFile(__dirname + "/public/register.html");
});

//DASHBOARD
app.get("/dashboard", verificarSesion, (req, res) => {
  res.sendFile(__dirname + "/private/dashboard.html");
});
//VENTAS
app.get("/ventas", verificarSesion, (req, res) => {
  res.sendFile(__dirname + "/private/ventas.html");
});
//INVENTORY
app.get("/inventory", verificarSesion, (req, res) => {
  res.sendFile(__dirname + "/private/inventory.html");
});
//HISTORIAL DE VENTAS DIARIO
app.get("/history", verificarSesion, (req, res) => {
  res.sendFile(__dirname + "/private/history.html");
});


//LOGIN
app.post("/login", (req, res) => {
  const { name, password } = req.body;

  db.query(
    "SELECT * FROM users WHERE name = ? AND password = ?",
    [name, password],
    (err, result) => {
      if (err) {
        console.error(err);
        return res.send("Server Error");
      }
      if (result.length > 0) {
        req.session.user = result[0];
        res.redirect("/dashboard");
      } else {
        res.redirect("/?error=1");
      }

    }
  );

});


//LOGOUT
app.get("/logout", (req, res) => {
  req.session.destroy(() => {
    res.redirect("/");
  });
});

//REGISTRO
app.post("/register", (req, res) => {

  const { name, password } = req.body;
  db.query(
    "INSERT INTO users (name, password) VALUES (?, ?)",
    [name, password],
    (err) => {
      if (err) {
        console.error(err);
        return res.send("Error registering user");
      }
      res.redirect("/");

    }
  );

});

// VENDER
app.post("/vender", verificarSesion, (req, res) => {
  const { album_id, cantidad } = req.body;
  db.query(
    "SELECT price, stock FROM albums WHERE id = ?",
    [album_id],
    (err, result) => {
      if (err) return res.send("Error");
      if (result.length === 0)
        return res.send("Album no encontrado");
      const album = result[0];
      if (album.stock < cantidad) {
        return res.send("Not enough stock");
      }
      const total = album.price * cantidad;
      db.query("INSERT INTO ventas (album_id, cantidad, total) VALUES (?, ?, ?)",
        [album_id, cantidad, total],
        (err) => {
          if (err) return res.send("Error when selling album");
          db.query("UPDATE albums SET stock = stock - ? WHERE id = ?",
            [cantidad, album_id],
            (err) => {
              if (err) return res.send("Error when updating stock");
                res.send("Sale completed✅");
            }
          );

        }
      );

    }
  );

});


//BUSCAR
// BUSCAR EN VENTAS
app.get("/buscar-ventas", verificarSesion, (req, res) => {

const nombre = req.query.nombre;

const query = `
SELECT * FROM albums 
WHERE tittle LIKE ? 
AND activo = TRUE
`;

db.query(query, [`%${nombre}%`], (err, results) => {

if (err) {
 console.error(err);
 return res.send("Error when searching");
}

res.json(results);

});

});
//FINALIZAR VENTA
app.post("/finalizar-venta", verificarSesion, (req, res) => {
  const { carrito, total } = req.body;
  const ventaQuery = `
    INSERT INTO ventas (total)
    VALUES (?)
  `;
  db.query(ventaQuery, [total], (err, result) => {
    if (err) throw err;
    const ventaId = result.insertId;
    carrito.forEach(item => {
      const detalleQuery = `INSERT INTO detalle_venta (venta_id, album_id, cantidad, precio) VALUES (?, ?, 1, ?)`;
      db.query(detalleQuery,
        [ventaId, item.id, item.price]
      );
      const stockQuery = `UPDATE albums SET stock = stock - 1 WHERE id = ?`;
      db.query(stockQuery, [item.id]);
    });
    res.json({ mensaje: "ok" });
  });

});

//INVENTORY

// OBTENER ALBUMS 
app.get("/albums", verificarSesion, (req, res) => {

db.query(
`SELECT albums.*, genre.name AS genero 
 FROM albums 
 JOIN genre ON albums.id_genre = genre.id 
 WHERE albums.activo = TRUE`,
(err, result) => {

if (err) {
 console.error(err);
 return res.send("Error retrieving albums");
}

res.json(result);

}
);

});
// ELIMINAR 
app.delete("/albums/:id", verificarSesion, (req, res) => {

const id = req.params.id;

db.query("UPDATE albums SET activo = FALSE WHERE id = ?",[id],(err, result) => {
if (err) {
 console.error(err);
 return res.send("Error deleting album");
}
res.send("Deleted album");
}
);
});

// AGREGAR
app.post("/albums", verificarSesion, (req, res) => {
const { title, artist, id_genre, anio, price, stock } = req.body;
db.query(
  "INSERT INTO albums (tittle, artist, id_genre, anio, price, stock) VALUES (?, ?, ?, ?, ?, ?)",
  [title, artist, id_genre, anio, price, stock],
  (err) => {

if (err) {
  console.error(err);
  return res.send("Error when adding album");
}
res.send("Album added");
}
);
});

//Buscar
// BUSCAR
app.get("/buscar", verificarSesion, (req, res) => {

const nombre = req.query.nombre;

const query = `
SELECT 
  albums.*, 
  genre.name AS genero
FROM albums
JOIN genre 
ON albums.id_genre = genre.id
WHERE albums.tittle LIKE ?
AND albums.activo = TRUE
`;

db.query(query, [`%${nombre}%`], (err, results) => {

if (err) {
 console.error(err);
 return res.send("Error when searching");
}

res.json(results);

});

});
// EDITAR
app.put("/albums/:id", verificarSesion, (req, res) => {
const id = req.params.id;
const { title, artist, id_genre, anio, price, stock } = req.body;
db.query(
"UPDATE albums SET tittle=?, artist=?, id_genre=?, anio=?, price=?, stock=? WHERE id=?",
[title, artist, id_genre, anio, price, stock, id],
(err) => {
if (err) {
  console.error(err);
  return res.send("Error when updating album");
}
res.send("Album updated");
}
);
});


// HISTORIAL DE VENTAS DEL DIA
app.get("/ventas-dia", verificarSesion, (req, res) => {

db.query(
`SELECT 
ventas.id,
ventas.fecha,
albums.tittle,
detalle_venta.cantidad,
detalle_venta.precio,
ventas.total

FROM ventas

JOIN detalle_venta 
ON ventas.id = detalle_venta.venta_id

JOIN albums 
ON detalle_venta.album_id = albums.id

WHERE DATE(ventas.fecha) = CURDATE()

ORDER BY ventas.fecha DESC`,
(err, result) => {

if (err) {
console.error(err);
return res.send("Error obtaining sales of the day");
}

res.json(result);

}

);

});


// HISTORIAL DEL DIA
app.get("/historial-dia", verificarSesion, (req, res) => {

db.query(
`SELECT ventas.id AS venta_id, ventas.fecha, albums.tittle, detalle_venta.cantidad, detalle_venta.precio, ventas.total

FROM ventas

JOIN detalle_venta 
ON ventas.id = detalle_venta.venta_id

JOIN albums 
ON detalle_venta.album_id = albums.id

WHERE DATE(ventas.fecha) = CURDATE()

ORDER BY ventas.fecha DESC`,
(err, result) => {

if (err) {
console.error(err);
return res.send("Error obtaining sales history");
}

res.json(result);

}

);

});

// TOTAL DE VENTAS DEL DIA
app.get("/total-dia", verificarSesion, (req, res) => {

db.query(
`SELECT SUM(total) AS total_dia
FROM ventas
WHERE DATE(fecha) = CURDATE()`,
(err, result) => {

if (err) {
console.error(err);
return res.send("Error obtaining total of the day");
}

res.json(result[0]);

}

);

});
