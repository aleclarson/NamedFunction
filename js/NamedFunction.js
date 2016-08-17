var NamedFunction, createImpl, isConfigurable;

require("isDev");

Object.defineProperty(Function.prototype, "getName", {
  writable: true,
  value: function() {
    return this.name;
  }
});

createImpl = function(isConfigurable, isDev) {
  var NamedFunction, renameFunction;
  NamedFunction = function NamedFunction(name, fn) { return renameFunction(fn, name) };
  if (!isDev) {
    renameFunction = function(fn, name) {
      fn.getName = function() {
        return name;
      };
      return fn;
    };
  } else if (isConfigurable) {
    renameFunction = function(fn, name) {
      Object.defineProperty(fn, "name", {
        value: name
      });
      fn.toString = NamedFunction.toString;
      return fn;
    };
    NamedFunction.toString = function() {
      return Function.prototype.toString.call(this).replace(/^function([^\(\r]+)/, "function " + this.name);
    };
  } else {
    renameFunction = function(orig, name) {
      var fn;
      fn = (Function("orig", "return function " + name + "() { return orig.apply(this, arguments) }"))(orig);
      fn.toString = function() {
        return Function.prototype.toString.call(orig).replace(/^function([^\(\r]+)/, "function " + name);
      };
      return fn;
    };
  }
  return NamedFunction;
};

isConfigurable = Object.getOwnPropertyDescriptor(Function, "name").configurable;

module.exports = NamedFunction = createImpl(isConfigurable, isDev);

NamedFunction.createImpl = createImpl;

//# sourceMappingURL=map/NamedFunction.map
