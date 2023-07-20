# Grafonnet example

This repository contains an example of a [Grafana dashboard](https://grafana.com/docs/grafana/latest/dashboards/)
[as code](https://grafana.com/blog/2022/12/06/a-complete-guide-to-managing-grafana-as-code-tools-tips-and-tricks/), 
defined with [Grafonnet](https://github.com/grafana/grafonnet), continuously deployed to 
a [Grafana Cloud](https://grafana.com/products/cloud/) instance, 
thanks to [Grizzly](https://github.com/grafana/grizzly) and [GitHub Actions](https://docs.github.com/en/actions).

## What's here?

- **An [example dashboard](./example.jsonnet)** written in [Jsonnet](https://jsonnet.org/) with [Grafonnet](https://github.com/grafana/grafonnet).
  - **Are you willing to extend it?** Find [here](https://grafana.github.io/grafonnet/API/dashboard/index.html) the Grafonnet API for dashboards.
- An example of **[how to use Grizzle to push dashboards to a Grafana instance](./.github/workflows/deploy.yml#L20)**.
  - **Would you like to learn more about Grizzly** Find [here](https://grafana.github.io/grizzly/) the docs.
- An example of **[how to continuously deploy Grafonnet code to a Grafana instance](./.github/workflows/deploy.yml)**.

## Looking for building your own example?

If you're a [learning-by-doing](https://en.wikipedia.org/wiki/Learning-by-doing) kind of person, you can follow the steps below to build your own example.

### Pre-requisites

First of all, you need to have these tools up and running before starting:

  - [Jsonnet](https://jsonnet.org/) (*[go-jsonnet](https://github.com/google/go-jsonnet#installation-instructions)* flavor)
  - [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler#install)
  - [Grafana Cloud](https://grafana.com/products/cloud/) instance (*with a [service account token](https://grafana.com/docs/grafana/latest/administration/service-accounts/#service-account-tokens) with enough permissions - e.g. admin*)

### Step by step

1. **Initialize** a new project:

    ```sh
    jb init
    ```

2. **Add Grafonnet** as dependency:

    ```sh
    jb install github.com/grafana/grafonnet/gen/grafonnet-latest@main
    ```

3. **Create an `example.jsonnet` file** with a basic dashboard:

    ```jsonnet
    local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
    
    g.dashboard.new('Grafonnet example')
    + g.dashboard.withDescription('Example dashboard built with Grafonnet')
    ```

4. **Create a `dashboards.libsonnet` file** with the main definition:

    ```jsonnet
    {
      grafanaDashboards+:: {
        'example.json': (import 'example.jsonnet'),
      },
    }
    ```

    *NOTE: It basically imports the example dashboard we defined in the previous step*

5. **Set up [Grafana auth for Grizzly](https://grafana.github.io/grizzly/authentication/#grafana-itself)** as [Actions secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets):

    - `GRAFANA_URL` with the root url of your instance
    - `GRAFANA_TOKEN` with your service account token

6. **Set up GitHub Actions** to automatically `grr apply` your changes on every push to `main`:

    ```yaml
    # .github/workflows/deploy.yml

    name: deploy
    
    on:
      push:
        branches:
          - main
    
    jobs:
      deploy:
        runs-on: ubuntu-latest
        container:
          image: grafana/grizzly:0.2.1-amd64
          env:
            GRAFANA_URL: ${{ secrets.GRAFANA_URL }}
            GRAFANA_TOKEN: ${{ secrets.GRAFANA_TOKEN }}
        steps:
          - name: Check out code
            uses: actions/checkout@v3
          - name: Deploy dashboards
            run: grr apply dashboards.libsonnet -l debug
    ```

7. **Push** new changes on `example.jsonnet` to `main` and **enjoy**!

## Contribute

**Have you detected a typo or something incorrect and you are willing to contribute?** 

Please, [open a pull request](https://github.com/joanlopez/grafonnet-example/compare), and I'll be happy to review it.
