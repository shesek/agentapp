express = require 'express'
appagent = require '../index.coffee'
http    = require 'http'
{ equal: eq } = require 'assert'

test_result = (expected, done) -> (err, res) ->
  return done err if err?
  eq res.text, expected
  done()

echo = (req, res) ->
  res.statusCode = 200
  res.setHeader 'Content-Type', 'text/plain'
  res.end "#{req.method} #{req.url}"

describe 'appagent', ->
  describe 'with http Server', ->
    describe 'when its listening', ->
      server = http.createServer echo
      server.listen(0)
      it 'should work', (done) ->
        appagent(server).get '/ping', test_result 'GET /ping', done

    describe 'when its not listening', (done) ->
      server = http.createServer echo
      it 'should work', (done) ->
        appagent(server).get '/ping', test_result 'GET /ping', done

  describe 'with express app', ->
    app = express()
    app.all '*', echo
    it 'should work', (done) ->
      appagent(app).put '/pong', test_result 'PUT /pong', done

  describe 'with function', ->
    it 'should work', (done) ->
      appagent(echo).post '/hello', test_result 'POST /hello', done

  it 'should alias delete as del', (done) ->
    appagent(echo).del '/foo', test_result 'DELETE /foo', done

  it 'allows to specify a base path', (done) ->
    appagent(echo, '/foo').get '/bar', test_result 'GET /foo/bar', done

  describe 'installation', ->
    it 'works', (done) ->
      app = express()
      app.put '/foo', echo
      appagent.install(app)
      app.client.put '/foo', test_result 'PUT /foo', done
