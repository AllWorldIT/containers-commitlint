[![pipeline status](https://gitlab.conarx.tech/containers/commitlint/badges/main/pipeline.svg)](https://gitlab.conarx.tech/containers/commitlint/-/commits/main)

# Container Information

[Container Source](https://gitlab.conarx.tech/containers/commitlint) - [GitHub Mirror](https://github.com/AllWorldIT/containers-commitlint)

This is the Conarx Containers CommitLint image, it provides commit linting support to GitLab CI pipelines.



# Mirrors

|  Provider  |  Repository                                |
|------------|--------------------------------------------|
| DockerHub  | allworldit/commitlint                      |
| Conarx     | registry.conarx.tech/containers/commitlint |



# Conarx Containers

All our Docker images are part of our Conarx Containers product line. Images are generally based on Alpine Linux and track the
Alpine Linux major and minor version in the format of `vXX.YY`.

Images built from source track both the Alpine Linux major and minor versions in addition to the main software component being
built in the format of `vXX.YY-AA.BB`, where `AA.BB` is the main software component version.

Our images are built using our Flexible Docker Containers framework which includes the below features...

- Flexible container initialization and startup
- Integrated unit testing
- Advanced multi-service health checks
- Native IPv6 support for all containers
- Debugging options



# Community Support

Please use the project [Issue Tracker](https://gitlab.conarx.tech/containers/commitlint/-/issues).



# Commercial Support

Commercial support for all our Docker images is available from [Conarx](https://conarx.tech).

We also provide consulting services to create and maintain Docker images to meet your exact needs.



# Environment Variables


## CI_PROJECT_DIR

Working directory.


## CI_MERGE_REQUEST_DIFF_BASE_SHA

Commit to lint from.


# Configuration

No commitlint configuration is required as defaults will be used, but if configuration is found it will be used instead.



# GitLab CI Recipe Example

```
commitlint:
  image: registry.conarx.tech/containers/commitlint
  stage: validate
  script:
    - commitlint --color --verbose --from "${CI_MERGE_REQUEST_DIFF_BASE_SHA}" --to HEAD
  rules:
    - if: $CI_MERGE_REQUEST_IID
```
