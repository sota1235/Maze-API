###
# maze.coffee
# 迷路を作成, 二次元配列で返す
###

module.exports = class Maze
  _         = require 'lodash'
  {Promise} = require 'es6-promise'

  # Errorをreturn
  errorResponse: () ->
    res =
      'result': 'NG'
    return res

  # 迷路データのjsonをreturn
  generateJson: (width, height) ->
    if not (20 <= width <= 200 or 20 <= width <= 200)
      return @errorResponse()
    # 迷路
    board = []
    # 壁で埋める
    for i in [0..height-1]
      line = []
      for j in [0..width-1]
        line.push '#'
      board.push line
    # スタート地点とゴール地点を空ける
    board[1][1]              = '.' # start
    # 穴掘り
    x = 1
    y = 1
    generateMaze x, y, board
      .then (result) ->
        board = result
      maze  = ""
      for i in [0..height-1]
        maze += board[i].join ''
        maze += '\n'

      # return作成
      res =
        'result': 'OK'
        'data':
          'width' : String width
          'height': String height
          'maze'  : maze
      return res

  # 穴掘り
  generateMaze = (x, y, board) ->
    return new Promise (resolve, reject) ->
      dir = _.shuffle([0, 1, 2, 3])
      height = board.length
      width  = board[0].length
      for d in dir
        if d is 0
          # 画面外処理
          if y-2 < 0
            continue
          if board[x][y-2] is '#'
            board[x][y-1] = board[x][y-2] = '.'
            generateMaze x, y-2, board
              .then (result) ->
                board = result
        else if d is 1
          if x+2 >= width
            continue
          if board[x+2][y] is '#'
            board[x+1][y] = board[x+2][y] = '.'
            generateMaze x+2, y, board
              .then (result) ->
                board = result
        else if d is 2
          if y+2 >= height
            continue
          if board[x][y+2] is '#'
            board[x][y+1] = board[x][y+2] = '.'
            generateMaze x, y+2, board
              .then (result) ->
                board = result
        else if d is 3
          if x-2 < 0
            continue
          if board[x-2][y] is '#'
            board[x-1][y] = board[x-2][y] = '.'
            generateMaze x-2, y, board
              .then (result) ->
                board = result
      resolve(board)
