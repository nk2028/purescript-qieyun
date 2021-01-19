{ name = "qieyun"
, dependencies =
  [ "console", "effect", "node-process", "nullable", "psci-support", "strings" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
