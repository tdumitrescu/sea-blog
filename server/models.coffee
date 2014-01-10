Sequelize = require "sequelize"
db        = require "./db"

exports.Post = db.default().connection.define "post",
  title: Sequelize.STRING,
  text:  Sequelize.STRING

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
