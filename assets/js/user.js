// Generated by CoffeeScript 1.4.0
(function() {
  var root,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Hive.UserHandler = (function(_super) {

    __extends(UserHandler, _super);

    function UserHandler() {
      this.name = 'userHandler';
      this.viewport = 'session';
      this.loadUser();
      console.log("Called this constructor");
    }

    UserHandler.prototype.bind = function(container) {
      this.container = container;
      this.logout = this.container.find('a');
      console.log(this.logout);
      return this.bindLink();
    };

    UserHandler.prototype.loadUser = function() {
      var self, _ref;
      console.log("Loading User");
      self = this;
      if ((_ref = Hive.data.user) != null ? _ref : this.data = Hive.data.user) {

      } else {
        return $.ajax({
          url: Hive.resource('me'),
          error: function(xhr, status, error) {},
          success: function(data, status, error) {
            Hive.data.user = data;
            return self.data = data;
          }
        });
      }
    };

    UserHandler.prototype.bindLink = function() {
      console.log("Called bind link");
      return this.logout.click(function(event) {
        event.preventDefault();
        console.log("Calling logout");
        return Hive.logout();
      });
    };

    return UserHandler;

  })(Hive.UiObject);

}).call(this);