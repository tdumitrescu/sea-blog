# server-side API for data manipulation exposed only in test env

Path       = require 'path'
serverPath = Path.join(__dirname, '..', '..', 'server')
db         = require "#{serverPath}/db"
{Post}     = require "#{serverPath}/models"

exPosts = [
  {title: "bla1", text: "Lorem ipsum" },
  {title: "bla2", text: "Sed egestas" },
  {title: "bla3", text: "Another post"}
]

specSetup = (done) -> db.init -> Post.bulkCreate(exPosts).success -> done()

passThrough = (req, res, next) -> next()

handleSpecRequests = (req, res, next) ->
  if req.path is "/_spec/setup"
    specSetup -> res.send 200
  else
    next()

module.exports = if process.env.NODE_ENV is "test" then handleSpecRequests else passThrough
