"use strict"

describe "blog post interaction", ->
  describe "index", ->
    beforeEach -> browser().navigateTo "/"

    it "lists the 2 posts", ->
      expect(repeater("[ng-view] h3").count()).toEqual 2

    it "displays the post titles", ->
      expect(element("[ng-view] h3:first").text()).toMatch /Lorem/
