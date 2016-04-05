
# NamedFunction v1.0.3 [![locked](http://badges.github.io/stability-badges/dist/locked.svg)](http://github.com/badges/stability-badges)

Rename any function.

```coffee
NamedFunction = require "NamedFunction"

Foo = NamedFunction "Foo", -> 1

Foo.name # => "Foo"

Foo()    # => 1
```
