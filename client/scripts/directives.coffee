'use strict'

### Directives ###

# register the module with Angular
angular.module('blogApp.directives', [
  # require the 'blogApp.services' module
  'blogApp.services'
])

.directive('appVersion', [
  'version'

(version) ->

  (scope, elm, attrs) ->
    elm.text(version)
])
