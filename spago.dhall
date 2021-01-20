{ name = "qieyun"
, dependencies =
  [ "effect", "nullable", "psci-support" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
