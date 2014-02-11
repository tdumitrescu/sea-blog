'use strict'

# jasmine specs for controllers go here

# TODO figure out how to test Controllers that use modules
describe "controllers", ->

  beforeEach(module "blogApp.controllers")

  describe "IndexCtrl", ->
    it "fetches posts list from the backend", inject ($rootScope, $controller, $httpBackend) ->
      scope       = $rootScope.$new()
      routeParams = jasmine.createSpy "routeParams"
      fakePosts   = [{title: "meow"}, {title: "moo"}]

      $httpBackend.expectGET('/api/posts').respond posts: fakePosts
      ctrl = $controller "IndexCtrl", $scope: scope, $routeParams: routeParams
      $httpBackend.flush()

      expect(scope.posts).toEqual fakePosts
