[![Build Status](https://travis-ci.org/tdumitrescu/angular-express-coffee-blog.png?branch=master)](https://travis-ci.org/tdumitrescu/angular-express-coffee-blog)

# Angular + Express + Brunch + Coffeescript Example App

A Coffeescript implementation of the [example app](https://github.com/btford/angular-express-blog) from Brian Ford's blog post ["Writing an AngularJS App with an Express + Node.js Backend"](http://briantford.com/blog/angular-express.html), with a somewhat different client-server architecture.

The starting point for the blog example is my Brunch template [Fast and Pointed Brunch](https://github.com/tdumitrescu/fast-and-pointed-brunch) rather than [Angular Express Seed](https://github.com/btford/angular-express-seed). The Brunch version handles Coffeescript on both client and server, while also stripping down the Express server so that it exposes only JSON API routes, serving everything else as pre-compiled static assets (including view templates).
