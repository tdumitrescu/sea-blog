'use strict'

# jasmine specs for directives go here
describe "directives", ->

  beforeEach(module "blogApp.directives")

  describe "app-version", ->

    it "prints current version", ->
      module ($provide) ->
        $provide.value "version", "TEST_VER"
        return

      inject ($compile, $rootScope) ->
        element = $compile("<span app-version></span>")($rootScope)
        expect(element.text()).toEqual "TEST_VER"


