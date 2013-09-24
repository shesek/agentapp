// Generated by CoffeeScript 1.3.3
(function() {
  "use strict";

  var AppAgent, exports, get_url, http, https, methods, request,
    __slice = [].slice;

  request = require('superagent');

  methods = require('methods');

  http = require('http');

  https = require('https');

  module.exports = exports = AppAgent = (function() {
    var _this = this;

    function AppAgent(app, path) {
      if (typeof this === "undefined" || this === null) {
        return new AppAgent(app, path);
      }
      if (typeof app !== 'string') {
        app = get_url(app);
      }
      if ((path != null) && path[0] !== '/') {
        path = '/' + path;
      }
      this.base = app + (path || '');
    }

    methods.forEach(function(method) {
      if (method === 'delete') {
        method = 'del';
      }
      return AppAgent.prototype[method] = function() {
        var a, path;
        path = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
        return request[method].apply(request, [this.base + path].concat(__slice.call(a)));
      };
    });

    return AppAgent;

  }).call(this);

  get_url = function(app, path) {
    var addr, protocol;
    if (path == null) {
      path = '';
    }
    if (typeof app === 'function') {
      app = http.createServer(app);
    }
    if (!(addr = app.address())) {
      addr = app.listen(0).address();
    }
    protocol = app instanceof https.Server ? 'https' : 'http';
    return "" + protocol + "://127.0.0.1:" + addr.port;
  };

  exports.install = function(target) {
    if (target == null) {
      target = http.Server.prototype;
    }
    return Object.defineProperty(target, 'client', {
      configurable: true,
      get: function() {
        var value;
        value = new AppAgent(this);
        Object.defineProperty(this, 'client', {
          value: value
        });
        return value;
      }
    });
  };

}).call(this);
