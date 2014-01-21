[![Build Status](https://travis-ci.org/tdumitrescu/sea-blog.png?branch=master)](https://travis-ci.org/tdumitrescu/sea-blog)

# SEA = SQL + Express + AngularJS
# Example App

An implementation of the [angular-express-coffee-blog](https://github.com/tdumitrescu/angular-express-coffee-blog) full-stack Javascript example, using PostgreSQL to provide a persisted data store.

## Setup

- Create and fill in `server/config/database.coffee` or `server/config/database.js` on the example of `server/config/database.coffee.example`
- Create database matching config in `database.coffee` (e.g., `psql -c 'create database sea_blog_development;' -U postgres`)
- Seed database: `./script/seed`
