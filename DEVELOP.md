# Publish the documentation

## Prepare

```sh
npm install -g pulp purescript bower spago
pulp login
```

## Test

Spago:

```sh
npm install
spago test --no-install
```

Bower:

```sh
bower install
```

## Publish

```sh
git tag v0.4.0
yes | pulp publish --no-push
```
