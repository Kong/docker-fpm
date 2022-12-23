# docker-fpm

This repository houses a `Dockerfile` and `docker-bake.hcl` which build a container around [fpm](https://fpm.readthedocs.io/en/latest/), the package manager used by [kong-build-tools](https://github.com/Kong/kong-build-tools/blob/d1c1b71e238b715b2a3ff551ab31628426a228df/dockerfiles/Dockerfile.package#L8).

## Contributing

Changes to this repo cause its Dockerfile to be automatically built and released by Github Actions when the commits for said changes confirm to [Semantic Release](https://semantic-release.gitbook.io/semantic-release/) conventions.
