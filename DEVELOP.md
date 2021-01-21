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
npm test
```

Bower:

```sh
bower install
```

## Publish

```sh
git tag v0.3.0
pulp publish --no-push
```
