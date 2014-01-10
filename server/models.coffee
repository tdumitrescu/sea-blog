console.log "initing DB"

Sequelize = require "sequelize"
DBConfig  = (require "./config/database").DBConfig.development

db = new Sequelize DBConfig.dbName, DBConfig.user, DBConfig.password, DBConfig.options

db.authenticate().complete (err) ->
  if err?
    console.log "Unable to connect to database: #{err}"
  else
    console.log "Connected to DB"

Post = db.define 'post',
  title: Sequelize.STRING,
  text:  Sequelize.STRING

db.sync().complete (err) ->
  if err?
    console.log "Unable to create posts table: #{err}"
  else
    console.log "Created posts table"

# initialize our faux database
exports.posts = 
  [
    {
      title: "Lorem ipsum"
      text:  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    {
      title: "Sed egestas"
      text:  "Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus."
    }
  ]
