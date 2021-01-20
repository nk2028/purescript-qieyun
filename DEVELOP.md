# Publish the documentation

## Prepare

```sh
npm install -g pulp purescript bower spago
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
git tag v0.1.0 # change the version number
pulp login
pulp publish --no-push
```
