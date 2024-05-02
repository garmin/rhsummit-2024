# rhsummit-2024

Related content for Garmin's presentations at RedHat Summit 2024

## Scaling OpenShift at Garmin: Leveraging Jsonnet, Tekton & ArgoCD
**Openshift Commons Gathering**

### Example 1 - Hierarchical Data Structures

This example uses Jsonnet to render a cluster configuration file from multiple hierarchically structured configuration files. A few things to notice:

* The way the imports tie each file together with its parent. The bottom-up approach makes adding new clusters very easy.
* Hidden items - any keys with `::` after them will be hidden from the output, but are available to Jsonnet during the rendering process
* Late binding / lazy language - fields like `self.environments` and `self.environment` aren't declared until the datacenter and cluster files, but are referenced in the all-clusters file.
* Look at the `name` attribute in the rendered output. When combining multiple objects, the right-most one wins. Both all-clusters and cluster01 have a name attribute.

Review these configuration files:

* [01-data-hierarchy/all-clusters.libsonnet](./01-data-hierarchy/all-clusters.libsonnet)
* [01-data-hierarchy/dc1/datacenter.libsonnet](./01-data-hierarchy/dc1/datacenter.libsonnet)
* [01-data-hierarchy/dc1/clusters/cluster01.libsonnet](./01-data-hierarchy/dc1/clusters/cluster01.libsonnet)

Execute Jsonnet against the cluster file to see the rendered results:

`jsonnet 01-data-hierarchy/dc1/clusters/cluster01.libsonnet`

### Example 2 - Openshift ConsoleNotification (Banner)

This example builds on the previous example. The rendered cluster configuration is passed as a top-level argument to the Jsonnet
interpreter. The template uses data from the cluster object to populate parts of the clusterNotification object.

Exclue Jsonnet to see the rendered results:

* `jsonnet -y --tla-code-file cluster="01-data-hierarchy/dc1/clusters/cluster01.libsonnet" 02-kube-object/consolenotification.jsonnet`

#### Installing Jsonnet

There are a few implementations of Jsonnet. The most commonly accepted is the `go` implementation. There is also a rust implementation.

* Simple: `brew install go-jsonnet`
  * *The examples have been tested against Jsonnet (Go implementation) v0.20.0*
* Less simple: Follow the [Installation Instructions on github.com/google/go-jsonnet](https://github.com/google/go-jsonnet#installation-instructions)

#### Useful Links & References

* [jsonnet.org](https://jsonnet.org/)
* [Jsonnet tutorial](https://jsonnet.org/learning/tutorial.html) - learn most of Jsonnet in an hour or two
* [Jsonnet Standard Library Reference](https://jsonnet.org/ref/stdlib.html) - this is where Jsonnet puts the fun in function. :)
* [Jsonnet on Slack](https://kubernetes.slack.com/) - join the `#jsonnet` channel.
