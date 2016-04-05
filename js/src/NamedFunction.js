var NamedFunction, signature, toString;

NamedFunction = function(name, fn) {
  Object.defineProperty(fn, "name", {
    value: name
  });
  fn.toString = toString;
  return fn;
};

signature = /^function([^\(]+)/;

toString = function() {
  return Function.prototype.toString.call(this).replace(signature, "function " + this.name);
};

module.exports = NamedFunction("NamedFunction", NamedFunction);

//# sourceMappingURL=../../map/src/NamedFunction.map
