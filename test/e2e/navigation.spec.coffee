"use strict"

describe "app navigation", ->
  beforeEach ->
    browser().navigateTo "/"

  it "stays on the root path when location hash/fragment is empty", ->
    expect(browser().location().url()).toBe "/"

  it "navigates to /addPost when the user clicks the Add Post link", ->
    element('a[href="/addPost"]').click()
    expect(browser().location().url()).toBe "/addPost"
