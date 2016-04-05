describe("NamedFunction", function() {
  return it("renames an existing function", function() {
    var Foo;
    Foo = NamedFunction("Foo", function() {
      return 1;
    });
    expect(Foo.name).toBe("Foo");
    return expect(Foo()).toBe(1);
  });
});

//# sourceMappingURL=../../map/spec/NamedFunction.map
