'use strict'

path    = require 'path'
request = require 'request'
expect  = require 'expect.js'

process.env.NODE_ENV = "test"

serverPath = path.join(__dirname, '..', '..', 'server')
server     = require "#{serverPath}/server"
db         = require "#{serverPath}/db"
{Post}     = require "#{serverPath}/models"
PORT       = 3434
API_BASE   = "http://localhost:#{PORT}/api"

before (done) -> server.startServer PORT, '/', done

beforeEach (done) -> db.init(done)

describe "server API", ->
  posts   = null
  exPosts = [
    {title: "bla1", text: "Lorem ipsum" },
    {title: "bla2", text: "Sed egestas" },
    {title: "bla3", text: "Another post"}
  ]

  loadPosts = (done) ->
    Post.findAll(order: 'id').success (p) ->
      posts = p
      done()

  beforeEach (done) -> Post.bulkCreate(exPosts).success -> loadPosts(done)

  describe "GET /posts", ->
    getPosts = (callback) -> request "#{API_BASE}/posts", callback

    it "returns data for all posts", (done) ->
      getPosts (error, response, body) ->
        expect(JSON.parse(body).posts).to.have.length(posts.length)
        done()

    it "includes the title of each post", (done) ->
      getPosts (error, response, body) ->
        expect(JSON.parse(body).posts[0].title).to.eql(exPosts[0].title)
        done()

    it "orders posts by ID", (done) ->
      getPosts (error, response, body) ->
        postIds = (p.id for p in JSON.parse(body).posts)
        expect(postIds).to.eql(postIds.sort())
        done()

  describe "POST /post", ->
    postData = {title: "new post", text: "blablabla"}
    postPost = (callback) -> request.post "#{API_BASE}/post", form: postData, callback

    it "creates a new post", (done) ->
      postLengthBefore = posts.length
      postPost (error, response, body) ->
        loadPosts ->
          expect(posts).to.have.length(postLengthBefore + 1)
          done()

    it "assigns the correct post data", (done) ->
      postPost (error, response, body) ->
        Post.find(where: {title: postData.title}).success (post) ->
          expect(post.title).to.eql postData.title
          expect(post.text).to.eql  postData.text
          done()

  describe "PUT /post/:id", ->
    putData = {title: "new title", text: "blablabla"}
    putPost = (callback, id = null) ->
      id ||= posts[0].id
      request.put "#{API_BASE}/post/#{id}", form: putData, callback

    it "does not create a new post", (done) ->
      postLengthBefore = posts.length
      putPost (error, response, body) ->
        loadPosts ->
          expect(posts).to.have.length postLengthBefore
          done()

    it "replaces the given post's data", (done) ->
      putPost (error, response, body) ->
        loadPosts ->
          expect(posts[0].title).to.eql putData.title
          expect(posts[0].text).to.eql  putData.text
          done()

    it "404s for invalid IDs", (done) ->
      putCallback = (error, response, body) ->
        expect(response.statusCode).to.eql 404
        done()
      putPost putCallback, -5

  # describe "DELETE /post/:id", ->
  #   postId = 0
  #   deletePost = (callback, id = postId) -> request.del "#{API_BASE}/post/#{id}", callback

  #   it "deletes a post", (done) ->
  #     postLengthBefore = posts.length
  #     deletePost (error, response, body) ->
  #       expect(posts).to.have.length(postLengthBefore - 1)
  #       done()

  #   it "shifts the other posts back", (done) ->
  #     shiftedPost = posts[postId + 1]
  #     deletePost (error, response, body) ->
  #       expect(posts[postId]).to.eql(shiftedPost)
  #       done()

  #   it "returns false for invalid IDs", (done) ->
  #     deleteCallback = (error, response, body) ->
  #       expect(JSON.parse(body)).to.be(false)
  #       done()
  #     deletePost deleteCallback, -5
