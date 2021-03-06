###
# Maze API
#
# @author sota1235
###

express = require 'express'
path    = require 'path'
app     = express()

Maze = require path.resolve 'model/maze.coffee'
MazeMaker = new Maze

# app set
app.set 'port', process.env.PORT || 3000
app.set 'view engine', 'jade'
app.set 'views', path.resolve 'views'

app.get '/', (req, res) ->
  res.render 'index', { title: 'Mazi API' }

app.get '/maze', (req, res) ->
  width  = req.query.width
  height = req.query.height
  if width == undefined or height == undefined
    json = MazeMaker.errorResponse()
  else
    json = MazeMaker.generateJson width, height
  res.contentType 'application/json'
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'X-Content-Type-Options', 'nosiff'
  res.send JSON.stringify json

app.use (req, res, next) ->
  res.status 404
  res.send 'Page Not Found'

app.listen app.get 'port'
