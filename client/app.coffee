'use strict'

# Declare app level module which depends on filters, and services
angular.module('blogApp', [
  'ngRoute',
  'blogApp.controllers', 'blogApp.filters', 'blogApp.services', 'blogApp.directives',
  'partials'
])
.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $routeProvider

    .when '/',
      templateUrl: '/partials/index.html'
      controller:  'IndexCtrl'

    .when '/addPost',
      templateUrl: '/partials/addPost.html'
      controller:  'AddPostCtrl'

    .when '/readPost/:id',
      templateUrl: '/partials/readPost.html'
      controller:  'ReadPostCtrl'

    .when '/editPost/:id',
      templateUrl: '/partials/editPost.html'
      controller:  'EditPostCtrl'

    .when '/deletePost/:id',
      templateUrl: '/partials/deletePost.html'
      controller:  'DeletePostCtrl'

    .otherwise redirectTo: '/'

  $locationProvider.html5Mode true
  ]
