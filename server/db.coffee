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
    @_default ||= (
      dbEnv = process.env.NODE_ENV || (
          console.log "NODE_ENV not defined. Defaulting to 'development'."
          "development"
        )
      envConfig = (require "./config/database").DBConfig[dbEnv] ||
        throw "No database configuration defined for environment '#{dbEnv}'."
      new Connection(envConfig))

  @init: (success) ->
    @default().connection.sync().complete (err) ->
      if err?
        console.log "Unable to sync DB: #{err}"
      else
        success()

module.exports = Connection
