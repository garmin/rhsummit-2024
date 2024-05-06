# rhsummit-2024

Related content for Garmin's presentations at RedHat Summit 2024


# Scaling OpenShift at Garmin: Leveraging Jsonnet, Tekton & ArgoCD
**Openshift Commons Gathering**

The examples below are designed to offer a quick bootstrap for using Jsonnet to templatize your configuration and automation.
See [Installing Jsonnet](./doc/Installing-Jsonnet.md) if needed.

## Example 1 - Hierarchical Data Structures

Use Jsonnet to render a complete cluster configuration file from multiple hierarchically structured configuration files.
* reduce duplication using object orientation to define cluster data
* minimize the amount of information needed to build a cluster

A few things to notice as you run this example:

* Imports tie each file together with its parent. The bottom-up approach makes adding new clusters very easy.
* Hidden items - any keys with `::` after them will be hidden from the output, but are available to Jsonnet during the rendering process
* Late binding / lazy language - fields like `self.environments` and `self.environment` aren't declared until the datacenter and cluster files, but are referenced in the all-clusters file.
* Notice the `name` attribute in the rendered output. When combining multiple objects, the right-most one wins. Both all-clusters and cluster01 have a name attribute.

#### Configuration Files

* [01-data-hierarchy/all-clusters.libsonnet](./01-data-hierarchy/all-clusters.libsonnet)
* [01-data-hierarchy/dc1/datacenter.libsonnet](./01-data-hierarchy/dc1/datacenter.libsonnet)
* [01-data-hierarchy/dc1/clusters/cluster01.libsonnet](./01-data-hierarchy/dc1/clusters/cluster01.libsonnet)

#### Rendering Output
Execute Jsonnet against the cluster file to see the rendered results:

* `jsonnet -J ./01-data-hierarchy 01-data-hierarchy/dc1/clusters/cluster01.libsonnet`

## Example 2 - Openshift ConsoleNotification (Banner)

This example builds on the previous example.
* The rendered cluster configuration is passed as a top-level argument to the Jsonnet interpreter.
* The template uses data from the cluster object to populate of the consoleNotification object.
* The rendered output is a kubernetes object; it can be applied manually or via automation to configure the cluster.

#### Template File

* [02-kube-object/consolenotification.jsonnet](./02-kube-object/consolenotification.jsonnet)

#### Rendering Output

Execute Jsonnet to see the rendered results:

* `jsonnet -y -J ./01-data-hierarchy --tla-code-file cluster="01-data-hierarchy/dc1/clusters/cluster01.libsonnet" 02-kube-object/consolenotification.jsonnet`

## Jsonnet Rust Implementation

There is a Rust implementation of Jsonnet as well as the de facto Go implementation. If you want to use the rust implementation, use these
commands to execute `jrsonnet` instead of `jsonnet`.

* `jrsonnet -J ./01-data-hierarchy 01-data-hierarchy/dc1/clusters/cluster01.libsonnet`
* `jrsonnet -y -f json -J ./01-data-hierarchy --tla-code-file cluster="01-data-hierarchy/dc1/clusters/cluster01.libsonnet" 02-kube-object/consolenotification.jsonnet`

#### Links & References

* [jsonnet.org](https://jsonnet.org/)
* [Jsonnet tutorial](https://jsonnet.org/learning/tutorial.html) - learn most of Jsonnet in an hour or two
* [Jsonnet Standard Library Reference](https://jsonnet.org/ref/stdlib.html) - this is where Jsonnet puts the fun in function. :)
* [Jsonnet on the Kubernetes Slack](https://kubernetes.slack.com/) - join the `#jsonnet` channel.
* [jrsonnet](https://github.com/CertainLach/jrsonnet) - Jsonnet Rust implementation
* [Installing Jsonnet](./doc/Installing-Jsonnet.md)


