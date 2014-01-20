#
# Module dependencies
#

express = require 'express'
http    = require 'http'
path    = require 'path'

db  = require "./db"
api = require "./api"

app = module.exports = express()

#
# Configuration
#

assetsPath = path.join(__dirname, '..', '_public')

# all environments
app.use express.logger('dev')
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.static(assetsPath)
app.use app.router

# development only
if app.get('env') is 'development'
  app.use express.errorHandler()

# production only
# if app.get('env') is 'production'
  # TODO

#
# Routes
#

# JSON API
app.get    "/api/posts",    api.posts
app.get    "/api/post/:id", api.post
app.post   "/api/post",     api.addPost
app.put    "/api/post/:id", api.editPost
app.delete "/api/post/:id", api.deletePost
app.get    "/api/*",        (req, res) -> res.send 'Not found', 404

# serve index for all other routes
app.get '*', (req, res) -> res.sendfile "#{assetsPath}/index.html"


#
# Start Server
#

module.exports.startServer = (port, path, callback) ->
  db.init ->
    app.set 'port', port
    http.createServer(app).listen port, ->
      console.log "Express server listening on port #{port}"
      callback()
