db     = require "./db"
{Post} = require "./models"

seedPosts = 
  [
    {
      title: "Lorem ipsum"
      text:  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    {
      title: "Sed egestas"
      text:  "Sed egestas, ante et vulputate volutpat, eros pede semper est, vitae luctus metus libero eu augue. Morbi purus libero, faucibus adipiscing, commodo quis, gravida id, est. Sed lectus."
    }
    {
      title: "Another post"
      text:  "Coming straight from Postgres to your face"
    }
  ]

db.init ->
  console.log "Creating seed posts..."
  Post.create(title: post.title, text: post.text) for post in seedPosts
