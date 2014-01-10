{Post} = require "./models"

# GET
exports.posts = (req, res) ->
  Post.findAll().success (posts) ->
    res.json posts: ({id: post.id, title: post.title, text: "#{post.text[0..50]}..."} for post in posts)

exports.post = (req, res) ->
  id = req.params.id
  res.json(
    if id >= 0 and id < data.posts.length
      post: data.posts[id]
    else
      false
  )

# POST
exports.addPost = (req, res) ->
  data.posts.push req.body
  res.json req.body

# PUT
exports.editPost = (req, res) ->
  id = req.params.id
  res.json(
    if id >= 0 and id < data.posts.length
      data.posts[id] = req.body
      true
    else
      false
  )

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
