{Post} = require "./models"

loadPost = (req, res, success) ->
  Post.find(req.params.id).success (post) ->
    if post? then success(post) else notFound(res)

notFound = (res) -> res.send 'Not found', 404

# GET
exports.posts = (req, res) ->
  Post.findAll(order: 'id').success (posts) ->
    res.json posts: ({id: post.id, title: post.title, text: "#{post.text[0..50]}..."} for post in posts)

exports.post = (req, res) ->
  loadPost req, res, (post) -> res.json post: post

# POST
exports.addPost = (req, res) ->
  pdata = req.body
  Post.create({title: pdata.title, text: pdata.text}).success (post) ->
    res.json post

# PUT
exports.editPost = (req, res) ->
  loadPost req, res, (post) ->
    post.updateAttributes(req.body).success(-> res.json true).error(-> res.json false)

# DELETE
exports.deletePost = (req, res) ->
  loadPost req, res, (post) ->
    post.destroy().success(-> res.json true).error(-> res.json false)
