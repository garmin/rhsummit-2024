local datacenter = import 'dc1/datacenter.libsonnet';

local cluster = {
  clusterType: "workload",
  name: "cluster01",
  environment: "sandbox",
  generatedConfigRevision: "jsonnet-demo",
  networkZone: "dmz"
};

datacenter + cluster
