Path       = require 'path'
serverPath = Path.join(__dirname, '..', 'server')
{db}       = require "../sequelizeTools"
{Post}     = require "#{serverPath}/models"

exPosts = [
  {title: "bla1", text: "Lorem ipsum" },
  {title: "bla2", text: "Sed egestas" },
  {title: "bla3", text: "Another post"}
]

module.exports =
  specSetup: (done) -> db.init -> Post.bulkCreate(exPosts).success -> done()
