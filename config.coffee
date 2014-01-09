exports.config =

  server:
    path: 'server/server.coffee'
    port: 3333
    base: '/'
    run:  yes

  # See docs at https://github.com/brunch/brunch/blob/stable/docs/config.md
  conventions:
    assets: /^client\/assets\//
    ignored: /^(bower_components\/bootstrap-less(-themes)?|client\/styles\/overrides)/
  modules:
    definition: false
    wrapper: false
  paths:
    public:  '_public'
    watched: ['client', 'vendor']
  files:
    javascripts:
      joinTo:
        'js/app.js': /^client/
        'js/vendor.js': /^(bower_components|vendor)/

    stylesheets:
      joinTo:
        'css/app.css': /^(client|vendor|bower_components)/
      order:
        before: [
          'client/styles/app.less'
        ]

    templates:
      joinTo: 
        'js/dontUseMe' : /^client/ # dirty hack for Jade compiling.

  plugins:
    jade:
      pretty: yes # Adds pretty-indentation whitespaces to output (false by default)
    jade_angular:
      modules_folder: 'partials'
      locals: {}

  # Enable or disable minifying of result js / css files.
  # minify: true
