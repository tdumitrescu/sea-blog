"use strict"

initDB = -> browser().navigateTo "/_spec/initdb"

describe "blog post interaction", ->
  beforeEach initDB

  describe "index", ->
    beforeEach -> browser().navigateTo "/"

    it "lists the 3 sample posts", ->
      expect(repeater("[ng-view] h3").count()).toEqual 3

    it "displays the post titles", ->
      expect(element("[ng-view] h3:first").text()).toEqual "bla1"
