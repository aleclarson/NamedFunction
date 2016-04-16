var createImpl;

createImpl = require("../src/NamedFunction").createImpl;

describe("NamedFunction", function() {
  it("does not override 'name' when not in __DEV__ mode", function() {
    var NamedFunction, fn, name, result;
    NamedFunction = createImpl(true, false);
    name = "Foo";
    fn = function() {
      return 1;
    };
    result = NamedFunction(name, fn);
    expect(result).toBe(fn);
    expect(result()).toBe(1);
    expect(result.name).toBe("");
    return expect(result.getName()).toBe(name);
  });
  it("overrides 'name' when it is configurable", function() {
    var NamedFunction, fn, name, result;
    NamedFunction = createImpl(true, true);
    name = "Foo";
    fn = function() {
      return 1;
    };
    result = NamedFunction(name, fn);
    expect(result).toBe(fn);
    expect(result()).toBe(1);
    expect(result.name).toBe(name);
    return expect(result.getName()).toBe(name);
  });
  return it("creates a new Function when 'name' is not configurable", function() {
    var NamedFunction, fn, name, result;
    NamedFunction = createImpl(false, true);
    name = "Foo";
    fn = function() {
      return 1;
    };
    result = NamedFunction(name, fn);
    expect(result).not.toBe(fn);
    expect(result()).toBe(1);
    expect(result.name).toBe(name);
    expect(result.getName()).toBe(name);
    return expect(fn.name).toBe("");
  });
});

//# sourceMappingURL=../../map/spec/NamedFunction.map
