# Installation Guide

## Prepare a `package.json` file

You need to have a `package.json` in your project root. If you do not have the file, create it:

```json
{
  "private": true
}
```

## Install qieyun-js

Run the following command:

```sh
npm install qieyun@0.11.0
```

This command will affect `package.json` and `package-lock.json`.

If you need to reinstall, run the following command:

```sh
npm install
```

## Install purescript-qieyun

Add the following lines in `packages.dhall`.

```dhall
  with qieyun =
    { dependencies = [ "effect", "nullable", "psci-support" ]
    , repo = "https://github.com/nk2028/purescript-qieyun.git"
    , version = "v0.1.1"
    }
```

Install the package:

```sh
spago install qieyun
spago build
```
