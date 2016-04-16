
# NamedFunction v2.0.0 [![stable](http://badges.github.io/stability-badges/dist/stable.svg)](http://github.com/badges/stability-badges)

Rename any function.

```coffee
NamedFunction = require "NamedFunction"

Foo = NamedFunction "Foo", -> 1

Foo.name # => "Foo"

Foo()    # => 1
```

**Check the tests for more details!**
