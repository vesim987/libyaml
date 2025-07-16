[![CI](https://github.com/allyourcodebase/libyaml/actions/workflows/ci.yaml/badge.svg)](https://github.com/allyourcodebase/libyaml/actions)

# libyaml

This is [libyaml](https://github.com/yaml/libyaml), packaged for [Zig](https://ziglang.org/).

## Installation

First, update your `build.zig.zon`:

```
# Initialize a `zig build` project if you haven't already
zig init
zig fetch --save git+https://github.com/allyourcodebase/libyaml.git#0.2.5
```

You can then import `libyaml` in your `build.zig` with:

```zig
const libyaml_dependency = b.dependency("libyaml", .{
    .target = target,
    .optimize = optimize,
});
your_exe.linkLibrary(libyaml_dependency.artifact("yaml"));
```

