'use strict'

class AppCtrl
  @$inject:    ["$scope", "$http", "$location", "$routeParams"]
  constructor: (@$scope, @$http, @$location, @$routeParams) -> @initialize()
  initialize:  ->

class IndexCtrl extends AppCtrl
  initialize: ->
    @$http.get("/api/posts")
      .success (data) => @$scope.posts = data.posts

class AddPostCtrl extends AppCtrl
  initialize: ->
    @$scope.form = {}
    @$scope.submitPost = =>
      @$http.post("/api/post", @$scope.form)
        .success (data) => @$location.path "/"

class ReadPostCtrl extends AppCtrl
  initialize: ->
    @$http.get("/api/post/#{@$routeParams.id}")
      .success (data) => @$scope.post = data.post

class EditPostCtrl extends AppCtrl
  initialize: ->
    @$scope.form = {}
    @$http.get("/api/post/#{@$routeParams.id}")
      .success (data) => @$scope.form = data.post

    @$scope.editPost = =>
      @$http.put("/api/post/#{@$routeParams.id}", @$scope.form)
        .success (data) => @$location.url "/readPost/#{@$routeParams.id}"

class DeletePostCtrl extends AppCtrl
  initialize: ->
    @$http.get("/api/post/#{@$routeParams.id}")
      .success (data) => @$scope.post = data.post

    @$scope.deletePost = =>
      @$http.delete("/api/post/#{@$routeParams.id}")
        .success (data) => @$location.url "/"

angular.module("blogApp.controllers", [])
  .controller("IndexCtrl",      IndexCtrl     )
  .controller("AddPostCtrl",    AddPostCtrl   )
  .controller("ReadPostCtrl",   ReadPostCtrl  )
  .controller("EditPostCtrl",   EditPostCtrl  )
  .controller("DeletePostCtrl", DeletePostCtrl)
