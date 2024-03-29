// Generated by CoffeeScript 1.4.0
(function() {
  var root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Hive.UserHandler = (function(_super) {

    __extends(UserHandler, _super);

    function UserHandler() {
      this.resource = 'me';
      this.name = 'userHandler';
      this.viewport = 'session';
      this.load();
      this.render();
    }

    UserHandler.prototype.bind = function(container) {
      this.container = container;
      this.logout = this.container.find('a');
      return this.bindLink();
    };

    UserHandler.prototype.bindLink = function() {
      return this.logout.click(function(event) {
        event.preventDefault();
        return Hive.Controller.setViewport('session', '', function() {
          return Hive.logout();
        });
      });
    };

    return UserHandler;

  })(Hive.UiObject);

}).call(this);
