data = require "./models"

# GET
exports.posts = (req, res) ->
  res.json posts: ({id: i, title: post.title, text: "#{post.text[0..50]}..."} for post, i in data.posts)

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
