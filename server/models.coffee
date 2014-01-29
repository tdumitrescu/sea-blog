Sequelize = require "sequelize"
{db}      = require "../sequelizeTools"

exports.Post = db.default().connection.define "post",
  title: Sequelize.STRING,
  text:  Sequelize.STRING
