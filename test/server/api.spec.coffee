'use strict'

path    = require 'path'
request = require 'request'
expect  = require 'expect.js'

process.env.NODE_ENV = "test"

serverPath = path.join(__dirname, '..', '..', 'server')
server     = require "#{serverPath}/server"
{Post}     = require "#{serverPath}/models"
PORT       = 3434
API_BASE   = "http://localhost:#{PORT}/api"

before (done) -> server.startServer PORT, '/', done

describe "server API", ->
  posts = null

  beforeEach (done) ->
    Post.findAll().success (p) ->
      posts = p
      done()

  describe "GET /posts", ->
    getPosts = (callback) -> request "#{API_BASE}/posts", callback

    it "returns data for all posts", (done) ->
      getPosts (error, response, body) ->
        expect(JSON.parse(body).posts).to.have.length(posts.length)
        done()

    # it "creates an ID for each post", (done) ->
    #   getPosts (error, response, body) ->
    #     expect(JSON.parse(body).posts[0].id).to.eql(0)
    #     done()

    # it "includes the title of each post", (done) ->
    #   getPosts (error, response, body) ->
    #     expect(JSON.parse(body).posts[0].title).to.eql(posts[0].title)
    #     done()

  # describe "POST /post", ->
  #   postData = {title: 'bla', text: 'blablabla'}
  #   postPost = (callback) -> request.post "#{API_BASE}/post", form: postData, callback

  #   it "creates a new post", (done) ->
  #     postLengthBefore = posts.length
  #     postPost (error, response, body) ->
  #       expect(posts).to.have.length(postLengthBefore + 1)
  #       done()

  #   it "assigns the correct post data", (done) ->
  #     newPostIndex = posts.length
  #     postPost (error, response, body) ->
  #       expect(posts[newPostIndex].title).to.eql(postData.title)
  #       expect(posts[newPostIndex].text).to.eql(postData.text)
  #       done()

  # describe "PUT /post/:id", ->
  #   putData = {title: 'bla', text: 'blablabla'}
  #   postId = posts.length - 1
  #   putPost = (callback, id = postId) ->
  #     request.put "#{API_BASE}/post/#{id}", form: putData, callback

  #   it "does not create a new post", (done) ->
  #     postLengthBefore = posts.length
  #     putPost (error, response, body) ->
  #       expect(posts).to.have.length(postLengthBefore)
  #       done()

  #   it "replaces the given post's data", (done) ->
  #     putPost (error, response, body) ->
  #       expect(posts[postId].title).to.eql(putData.title)
  #       expect(posts[postId].text).to.eql(putData.text)
  #       done()

  #   it "returns false for invalid IDs", (done) ->
  #     putCallback = (error, response, body) ->
  #       expect(JSON.parse(body)).to.be(false)
  #       done()
  #     putPost putCallback, -5

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
