"use strict"
 
request = require 'superagent'
methods = require 'methods'
http    = require 'http'
https   = require 'https'

module.exports = exports = class AppAgent
  constructor: (app, path) ->
    return new AppAgent app, path unless this?
    app = get_url app unless typeof app is 'string'
    path = '/' + path if path? and path[0] isnt '/'
    @base = app + (path or '')

  methods.forEach (method) =>
    method = 'del' if method is 'delete'
    @::[method] = (path, a...) -> request[method] @base+path, a...

get_url = (app, path='') ->
  app = http.createServer app if typeof app is 'function'
  addr = app.listen(0).address() unless addr = app.address()
  protocol = if app instanceof https.Server then 'https' else 'http'
  "#{protocol}://127.0.0.1:#{addr.port}"

exports.install = (target=http.Server::) ->
  Object.defineProperty target, 'client', configurable: true, get: ->
    value = new AppAgent this
    Object.defineProperty this, 'client', { value }
    value
