'use strict'

path    = require 'path'
request = require 'request'
expect  = require 'expect.js'

process.env.NODE_ENV = "test"

basePath   = path.join(__dirname, '..', '..')
serverPath = path.join(basePath, 'server')
server     = require "#{serverPath}/server"
{db}       = require "sequelize-tools"
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

  assertStatus = (statusCode, done, sendRequest) ->
    sendRequest (error, response, body) ->
      expect(response.statusCode).to.be statusCode
      done()

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
    putData   = {title: "new title", text: "blablabla"}
    postIndex = 1
    putPost = (callback, id = null) ->
      id ||= posts[postIndex].id
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
          expect(posts[postIndex].title).to.eql putData.title
          expect(posts[postIndex].text).to.eql  putData.text
          done()

    it "404s for invalid IDs", (done) ->
      assertStatus 404, done, (cb) -> putPost cb, -5

  describe "DELETE /post/:id", ->
    postIndex = 1
    deletePost = (callback, id = null) ->
      id ||= posts[postIndex].id
      request.del "#{API_BASE}/post/#{id}", callback

    it "deletes the correct post", (done) ->
      postID = posts[postIndex].id
      Post.find(postID).success (post) ->
        expect(post).not.to.be null
        deletePost (error, response, body) ->
          Post.find(postID).success (post) ->
            expect(post).to.be null
            done()

    it "deletes only one post", (done) ->
      postLengthBefore = posts.length
      deletePost (error, response, body) ->
        loadPosts ->
          expect(posts).to.have.length(postLengthBefore - 1)
          done()

    it "404s for invalid IDs", (done) ->
      assertStatus 404, done, (cb) -> deletePost cb, "blargh"
