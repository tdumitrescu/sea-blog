'use strict'

class IndexCtrl
  @$inject:    ['$scope', '$http']
  constructor: (@$scope, @$http) ->
    $http.get("/api/posts")
      .success (data) => @$scope.posts = data.posts

angular.module('blogApp.controllers', [])

.controller('IndexCtrl', IndexCtrl)

.controller('AddPostCtrl', ["$scope", "$http", "$location", ($scope, $http, $location) ->
  $scope.form = {}
  $scope.submitPost = ->
    $http.post("/api/post", $scope.form)
      .success (data) -> $location.path "/"
  ])

.controller('ReadPostCtrl', ["$scope", "$http", "$routeParams", ($scope, $http, $routeParams) ->
  $http.get("/api/post/#{$routeParams.id}")
    .success (data) -> $scope.post = data.post
  ])

.controller('EditPostCtrl', ["$scope", "$http", "$location", "$routeParams",
  ($scope, $http, $location, $routeParams) ->
    $scope.form = {}
    $http.get("/api/post/#{$routeParams.id}")
      .success (data) -> $scope.form = data.post

    $scope.editPost = ->
      $http.put("/api/post/#{$routeParams.id}", $scope.form)
        .success (data) -> $location.url "/readPost/#{$routeParams.id}"
  ])

.controller('DeletePostCtrl', ["$scope", "$http", "$location", "$routeParams",
  ($scope, $http, $location, $routeParams) ->
    $http.get("/api/post/#{$routeParams.id}")
      .success (data) -> $scope.post = data.post

    $scope.deletePost = ->
      $http.delete("/api/post/#{$routeParams.id}")
        .success (data) -> $location.url "/"

    $scope.home = -> $location.url "/"
  ])
