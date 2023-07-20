# Grafonnet example

This repository contains an example of a Grafana dashboard as code, defined with [Grafonnet](https://github.com/grafana/grafonnet), continuously deployed to a [Grafana Cloud](https://grafana.com/products/cloud/) instance, thanks to [Grizzly](https://github.com/grafana/grizzly) and [GitHub Actions](https://docs.github.com/en/actions).

## Looking for building your own example?

If you're a [learning-by-doing](https://en.wikipedia.org/wiki/Learning-by-doing) kind of person, you can follow the steps below to build your own example.

### Pre-requisites

First of all, you need to have these tools up and running before starting:

  - [Jsonnet](https://jsonnet.org/) (*[go-jsonnet](https://github.com/google/go-jsonnet#installation-instructions)* flavor)
  - [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler#install)
  - [Grafana Cloud](https://grafana.com/products/cloud/) instance (*with a [service account token](https://grafana.com/docs/grafana/latest/administration/service-accounts/#service-account-tokens) with enough permissions - e.g. admin*)

### Step by step

1. Initialize a new project:

    ```sh
    jb init
    ```

2. Add Grafonnet as dependency:

    ```sh
    jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main
    ```

3. Create an `example.jsonnet` file with a basic dashboard:

    ```jsonnet
    local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
    
    g.dashboard.new('Grafonnet example')
    + g.dashboard.withDescription('Example dashboard built with Grafonnet')
    ```

4. Create a `dashboards.libsonnet` file with the main definition:

    ```jsonnet
    {
      grafanaDashboards+:: {
        'example.json': (import 'example.jsonnet'),
      },
    }
    ```

    *NOTE: It basically imports the example dashboard we defined in the previous step*

5. Set up [Grafana auth for Grizzly](https://grafana.github.io/grizzly/authentication/#grafana-itself) as [Actions secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets):

    - `GRAFANA_URL` with the root url of your instance
    - `GRAFANA_TOKEN` with your service account token




