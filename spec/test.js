
var global1 = 'a';
var global2 = 2;
var global3;

module.exports.exportVar1 = 'export test';

function func1() {
  var local1 = 4;
  var local2 = 2;
  return local1 + local2;
}

// This is a multiline double-slash commentator
// for function func2()
// @param param: This function's only parameter.
// @returns:     Twice the value of param.
function func2(param) {
  return param * 2;
}

/**
* This is a block header for function func3().
* @returns:       10.
*/
function func3() {
  var local1 = 5;
  var local2 = local1 * 2;
  return local2;
}

function func4() {
  console.log(module.exports.exportVar1);
}

var test1 = function() {
  var param = 5;
  return function() {
    return 10;
  };
}
