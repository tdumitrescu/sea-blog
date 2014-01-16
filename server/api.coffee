{Post} = require "./models"

# GET
exports.posts = (req, res) ->
  Post.findAll().success (posts) ->
    res.json posts: ({id: post.id, title: post.title, text: "#{post.text[0..50]}..."} for post in posts)

exports.post = (req, res) ->
  Post.find(req.params.id).success (post) ->
    res.json if post? then {post: post} else false

# POST
exports.addPost = (req, res) ->
  pdata = req.body
  Post.create({title: pdata.title, text: pdata.text}).success (post) ->
    res.json post

# PUT
exports.editPost = (req, res) ->
  Post.find(req.params.id).success (post) ->
    post.updateAttributes(req.body).success(-> res.json true).error(-> res.json false)

# DELETE
exports.deletePost = (req, res) ->
  id = req.params.id
  res.json(
    if id >= 0 and id < data.posts.length
      data.posts.splice id, 1
      true
    else
      false
  )
