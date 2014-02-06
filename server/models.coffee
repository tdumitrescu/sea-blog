Sequelize = require "sequelize"
{db}      = require "../sequelize-tools"

exports.Post = db.default().connection.define "post",
  title: Sequelize.STRING,
  text:  Sequelize.STRING
