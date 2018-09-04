
isDev = require "isDev"

# Use 'getName' as the safe way of getting
# a function name in any environment.
Object.defineProperty Function.prototype, "getName",
  configurable: yes
  writable: yes
  value: -> @name

createImpl = (isDev) ->

  NamedFunction = `function NamedFunction(name, fn) { return renameFunction(fn, name) }`

  if isDev

    renameFunction = (orig, name) ->
      fn = Function("orig", "return function " + name + "() { return orig.apply(this, arguments) }")(orig)
      Object.defineProperty fn, "__orig", {value: orig}
      fn.toString = NamedFunction.toString
      return fn

    NamedFunction.toString = ->
      Function::toString
        .call @__orig
        .replace /^function([^\(\r]+)/, "function " + @name

  else
    renameFunction = (fn, name) ->
      fn.getName = -> name
      return fn

  NamedFunction.createImpl = createImpl

  return NamedFunction

module.exports = NamedFunction = createImpl isDev
