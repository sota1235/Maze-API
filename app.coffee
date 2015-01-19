###
# Maze API
#
# @author sota1235
###

express = require 'express'
app     = express()

app.get '/', (req, res) ->
  res.send 'Hello, World'

app.listen 3000
