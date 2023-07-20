local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

g.dashboard.new('Grafonnet example')
+ g.dashboard.withDescription('Example dashboard built with Grafonnet')
