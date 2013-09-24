## appagent

Send requests to local HTTP servers (http.Server, express, connect or a function) with
[superagent](http://visionmedia.github.io/superagent/).

Inspired by [supertest](https://github.com/visionmedia/supertest)'s
`request(app).method()` API.

### Installation

Install the `appagent` and `superagent` packages from npm.
The superagent package should be installed alongside appagent
(it is not installed as a dependency of appagent - it expects it to
already be installed by a parent package).


```bash
$ npm install appagent superagent
```

### Usage

```js
var appagent = require('appagent')
  , app = require('express')();

// Without installing
var request = appagent(app);
request.get('/', function(err, res) { ... });
request.post('/').end(function(err, res) { ... });

// Install as a `request` property of an app
appagent.install(app);
app.request.put('/', ...);

// Or install globally on http.Server prototype
appagent.install();
```

### License
MIT
