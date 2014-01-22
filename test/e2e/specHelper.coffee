# server-side API for data manipulation to be exposed only in test env

Path       = require 'path'
serverPath = Path.join(__dirname, '..', '..', 'server')
db         = require "#{serverPath}/db"
{Post}     = require "#{serverPath}/models"

exPosts = [
  {title: "bla1", text: "Lorem ipsum" },
  {title: "bla2", text: "Sed egestas" },
  {title: "bla3", text: "Another post"}
]

exports.initDB = (req, res) ->
  db.init -> Post.bulkCreate(exPosts).success -> res.send 200
