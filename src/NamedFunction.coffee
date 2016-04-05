
NamedFunction = (name, fn) ->
  Object.defineProperty fn, "name", { value: name }
  fn.toString = toString
  return fn

signature = /^function([^\(]+)/
toString = ->
  Function::toString
    .call this
    .replace signature, "function " + @name

module.exports = NamedFunction "NamedFunction", NamedFunction
