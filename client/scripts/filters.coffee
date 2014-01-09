'use strict'

### Filters ###

angular.module('blogApp.filters', [])

.filter('interpolate', [
  'version',

(version) ->
  (text) ->
    String(text).replace(/\%VERSION\%/mg, version)
])
