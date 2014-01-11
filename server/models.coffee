Sequelize = require "sequelize"
db        = require "./db"

exports.Post = db.default().connection.define "post",
  title: Sequelize.STRING,
  text:  Sequelize.STRING
