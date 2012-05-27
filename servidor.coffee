express = require 'express'
http = require 'http'
Palabra = require('./palabra')()

app = express()

app.configure () ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.static(__dirname + '/public')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router

app.configure 'development', () ->
  app.use express.errorHandler()
  
rand = require './rand'
  
palabras = [
  new Palabra "amor",rand(), rand()
  new Palabra "la",rand(), rand()
  new Palabra "atención",rand(), rand()
  new Palabra "vida",rand(), rand()
  new Palabra "feedback",rand(), rand()
  new Palabra "somos",rand(), rand()
  new Palabra "noche",rand(), rand()
  new Palabra "veces",rand(), rand()
  new Palabra "es",rand(), rand()
  new Palabra "chance",rand(), rand()
  new Palabra "el",rand(), rand()
  new Palabra "todo",rand(), rand()
  new Palabra "cielo",rand(), rand()
  new Palabra "mañana",rand(), rand()
  new Palabra "cama",rand(), rand()
  new Palabra "miedo",rand(), rand()
  new Palabra "día",rand(), rand()
  new Palabra "el",rand(), rand()
  new Palabra "que",rand(), rand()
  new Palabra "siempre",rand(), rand()
  new Palabra "s",rand(), rand()
  new Palabra "contigo",rand(), rand()
  new Palabra "ciudad",rand(), rand()
  new Palabra "triste",rand(), rand()
  new Palabra "luz",rand(), rand()
  new Palabra "arándanos",rand(), rand()
  new Palabra "tu",rand(), rand()
  new Palabra "como",rand(), rand()
  new Palabra "chévere",rand(), rand()
  new Palabra "tiene",rand(), rand()
  new Palabra "a",rand(), rand()
  new Palabra "más",rand(), rand()
  new Palabra "y",rand(), rand()
  new Palabra "música",rand(), rand()
  new Palabra "mil",rand(), rand()
  new Palabra "si",rand(), rand()
  new Palabra "soy",rand(), rand()
  new Palabra "no",rand(), rand()
  new Palabra "cuando",rand(), rand()
  new Palabra "hay",rand(), rand()
  new Palabra "sol",rand(), rand()
  new Palabra "los",rand(), rand()
  new Palabra "frío",rand(), rand()
  new Palabra "de",rand(), rand()
]

# Rutas
app.get '/', (req,res) ->
  res.render 'index', { palabras: palabras }


server = app.listen 3000

# socket.io
io = require('socket.io').listen server
io.set 'log level', 1 # Establece el nivel de detalle del log del servidor

io.sockets.on 'connection', (socket) ->
  
  socket.on 'mover', (d) -> 
    palabras[d.data.id].x = d.data.pos.left
    palabras[d.data.id].y = d.data.pos.top
    # Envía un mensaje broadcast a todos los clientes con la información de la palabra movida
    socket.broadcast.emit 'mover', {data: palabras[d.data.id], id: d.data.id} 

console.log "Servidor express escuchando en el puerto 3000"
