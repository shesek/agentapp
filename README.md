## appagent

Send requests to local HTTP servers (http.Server, express, connect or a function) with
[superagent](http://visionmedia.github.io/superagent/).

Inspired by [supertest](https://github.com/visionmedia/supertest)'s
`request(app).method()` API.

### Install

```bash
$ npm install appagent
```

### Usage

```js
var appagent = require('appagent')
  , app = require('express')();

// Without installing
var request = appagent(app);
request.get('/', function(err, res) { ... });
request.post('/').end(function(err, res) { ... });

// Install as a `client` property of an app
request.install(app);
app.client.put('/', ...);

// Or install globally on http.Server prototype, to make it available
// on all apps
request.install();
```

### License
MIT
