# Grafonnet example

This repository contains an example of a Grafana dashboard as code, defined with [Grafonnet](https://github.com/grafana/grafonnet), continuously deployed to a [Grafana Cloud](https://grafana.com/products/cloud/) instance, thanks to [Grizzly](https://github.com/grafana/grizzly) and [GitHub Actions](https://docs.github.com/en/actions).

## Looking for building your own example?

If you're a [learning-by-doing](https://en.wikipedia.org/wiki/Learning-by-doing) kind of person, you can follow the steps below to build your own example.

### Pre-requisites

First of all, you need to have these tools up and running before starting:

  - [Jsonnet](https://jsonnet.org/) (*[go-jsonnet](https://github.com/google/go-jsonnet#installation-instructions)* flavor)
  - [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler#install)

### Step by step

1. Initialize a new project:

    `jb init`

2. Add Grafonnet as dependency:

    `jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main`





