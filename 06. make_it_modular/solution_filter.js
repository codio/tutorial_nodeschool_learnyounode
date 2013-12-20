var fs = require('fs')

module.exports = function (dir, filterStr, callback) {
  var regex = new RegExp('\\.' + filterStr + '$')

  fs.readdir(dir, function (err, list) {
    if (err)
      return callback(err)

    list = list.filter(function (file) {
      return regex.test(file)
    })

    callback(null, list)
  })
}

// The following functions are shown to show how several methods can be exported within a module
var PI = Math.PI;

exports.area = function (r) {
  return PI * r * r;
}

exports.circumference = function (r) {
  return 2 * PI * r;
}
