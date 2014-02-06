Path      = require "path"
Sequelize = require "sequelize"

class Connection
  constructor: (attrs) ->
    @attrs   = attrs
    @testEnv = @attrs.testEnv? and @attrs.testEnv

    console.log "Initializing DB connection for #{@attrs.dbName}"

    @connection = new Sequelize @attrs.dbName, @attrs.user, @attrs.password, @attrs.options
    @connection.authenticate().complete (err) =>
      if err?
        console.log "Unable to connect to database: #{err}"
      else
        console.log "Connected to #{@attrs.dbName}"

  @default: ->
    @_default ||= (
      dbEnv = @chooseEnv()
      configPath = require.resolve(Path.resolve("server/config/database"))
      envConfig = (require configPath).DBConfig[dbEnv] ||
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
    @default().sync().complete (err) ->
      if err?
        console.log "Unable to sync DB: #{err}"
      else
        success()

  sync: -> @connection.sync(force: @testEnv)

module.exports = Connection
