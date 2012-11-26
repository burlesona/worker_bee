// Generated by CoffeeScript 1.4.0
(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Hive.UI = {
    viewport: $('section#main'),
    clear: function() {
      return this.viewport.fadeOut(1000).html('');
    }
  };

  Hive.Templates = {
    loginHandler: function() {
      return "<div id=\"login\">\n	<h1>Welcome to Worker Bee</h1>\n	<p>Please login with your AgileZen API Key.</p>\n	<div class=\"input\">\n		<form action=\"/\" method=\"get\">\n			<input id=\"api_key\" type=\"text\"></input>\n			<input type=\"submit\" value=\"Login\"></input>\n		</form>\n	</div>\n	<p class=\"hint\">Test API Key: d67bb4e8a3124603a69f7587020cffc2</p>\n</div>";
    }
  };

}).call(this);