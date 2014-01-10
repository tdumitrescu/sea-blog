class Connection
  constructor: (attrs) ->
    console.log "initializing DB connection for #{attrs.dbName}"

    Sequelize = require "sequelize"
    @connection = new Sequelize attrs.dbName, attrs.user, attrs.password, attrs.options
    @connection.authenticate().complete (err) ->
      if err?
        console.log "Unable to connect to database: #{err}"
      else
        console.log "Connected to #{attrs.dbName}"

  @default: ->
    @_default ||= new Connection((require "./config/database").DBConfig.development)

  @init: (success) ->
    @default().connection.sync().complete (err) ->
      if err?
        console.log "Unable to sync DB: #{err}"
      else
        success()

module.exports = Connection
