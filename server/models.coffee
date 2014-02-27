Sequelize = require "sequelize"
{db}      = require "sequelize-tools"

exports.Post = db.sequelize().define "post",
  title: Sequelize.STRING,
  text:  Sequelize.STRING
