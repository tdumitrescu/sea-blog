class Connection
  constructor: (attrs) ->
    @attrs   = attrs
    @testEnv = @attrs.testEnv? and @attrs.testEnv

    console.log "initializing DB connection for #{@attrs.dbName}"

    Sequelize = require "sequelize"
    @connection = new Sequelize @attrs.dbName, @attrs.user, @attrs.password, @attrs.options
    @connection.authenticate().complete (err) =>
      if err?
        console.log "Unable to connect to database: #{err}"
      else
        console.log "Connected to #{@attrs.dbName}"

  @default: ->
    @_default ||= (
      dbEnv = @chooseEnv()
      envConfig = (require "./config/database").DBConfig[dbEnv] ||
        throw "No database configuration defined for environment '#{dbEnv}'."
      envConfig.testEnv = true if dbEnv is "test"
      new Connection(envConfig))

  @chooseEnv: ->
    process.env.NODE_ENV = "test" if process.env.npm_lifecycle_event is "test"
    process.env.NODE_ENV || (
        console.log "NODE_ENV not defined. Defaulting to 'development'."
        "development"
      )

  @init: (success) ->
    @default().connection.sync(force: @testEnv).complete (err) ->
      if err?
        console.log "Unable to sync DB: #{err}"
      else
        success()

module.exports = Connection
