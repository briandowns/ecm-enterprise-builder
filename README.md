# ECM Enterprise Builder

## Build k3s

```sh
make ent-k3s
```

With FIPS: 

```sh
FIPS=true make ent-k3s
```

## Build Rancher

By default, enterprise Rancher will build binaries with `-enterprise` appended to the name of the server and agent binaries. This can be overriden by setting the `PROG` var at build time.

```sh
make ent-rancher
```

With FIPS: 

```sh
FIPS=true make ent-rancher
```

With name override: 

```sh
PROG="-something-else" make ent-rancher
```
