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
spago test
```

Bower:

```sh
bower install
```

## Publish

```sh
git tag v0.5.0
yes | pulp publish --no-push
```
