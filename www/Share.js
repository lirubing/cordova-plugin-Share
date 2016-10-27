var exec = require('cordova/exec');

exports.share = function(arg0, success, error) {
    exec(success, error, "Share", "share", [arg0]);
};
