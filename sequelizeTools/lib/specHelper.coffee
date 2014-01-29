# server-side API for data manipulation exposed only in test env
# pass request handlers (specSetup) to registerHandlers()

reqHandlers = {}

passThrough        = (req, res, next) -> next()
handleSpecRequests = (req, res, next) ->
  if req.path is "/_spec/setup"
    reqHandlers.specSetup -> res.send 200
  else
    next()

reqHelper = if process.env.NODE_ENV is "test" then handleSpecRequests else passThrough
reqHelper.registerHandlers = (handlers) ->
  (reqHandlers[k] = v) for k, v of handlers

module.exports = reqHelper
