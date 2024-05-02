function(cluster)

local clusterBranch = std.get(cluster, "generatedConfigRevision", default="");
local clusterBranchDisplay = if std.length(clusterBranch) == 0 then "" else " - [" + clusterBranch + "]";

[
  {
    apiVersion: "console.openshift.io/v1",
    kind: "ConsoleNotification",
    metadata: {
      name: "bannertop"
    },
    spec: {
      backgroundColor: cluster.bannerColors[cluster.environment],
      color: "#fff",
      location: "BannerTop",
      text: std.join(" / ", [ cluster.environment, cluster.datacenter, cluster.networkZone, cluster.name ]) + clusterBranchDisplay
    }
  }
]
