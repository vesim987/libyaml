const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("upstream", .{});

    const libyaml_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });
    libyaml_mod.link_libc = true;
    libyaml_mod.addIncludePath(upstream.path("include"));

    libyaml_mod.addCSourceFiles(.{
        .root = upstream.path("src"),
        .files = &.{
            "api.c",
            "dumper.c",
            "emitter.c",
            "loader.c",
            "parser.c",
            "reader.c",
            "scanner.c",
            "writer.c",
        },
        .flags = &.{
            "-DHAVE_CONFIG_H=1",
        },
    });

    const config_header = b.addConfigHeader(.{
        .style = .{ .cmake = upstream.path("cmake/config.h.in") },
    }, .{
        .YAML_VERSION_MAJOR = 0,
        .YAML_VERSION_MINOR = 2,
        .YAML_VERSION_PATCH = 5,
        .YAML_VERSION_STRING = "0.2.5",
    });
    libyaml_mod.addConfigHeader(config_header);

    const libyaml = b.addLibrary(.{
        .linkage = .static,
        .name = "yaml",
        .root_module = libyaml_mod,
    });
    libyaml.installHeader(upstream.path("include/yaml.h"), "yaml.h");

    b.installArtifact(libyaml);
}
