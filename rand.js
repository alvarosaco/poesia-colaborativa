(function() {

  module.exports = function(max) {
    if (max != null) {
      return Math.floor(50 + Math.random() * max);
    } else {
      return Math.floor(50 + Math.random() * 550);
    }
  };

}).call(this);
