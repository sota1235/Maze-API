###
# Maze API
#
# @author sota1235
###

express = require 'express'
path    = require 'path'
app     = express()

# app set
app.set 'view engine', 'jade'
app.set 'views', path.resolve 'views'

app.get '/', (req, res) ->
  res.render 'index', { title: 'Mazi API' }

app.listen 3000
