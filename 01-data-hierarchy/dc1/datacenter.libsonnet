local allClusters = import '../all-clusters.libsonnet';

local datacenter = {
  clusterType: 'workload',
  region: 'region1',
  datacenter: 'dc1',
  environments:: {
    prod: {
      hypervisorDatastore: 'DC1-HYPRVSR01-DATA-01',
    },
    sandbox: {
      hypervisorDatastore: 'DC1-HYPRVSR01-DATA-02',
    },
    nonprod: {
      hypervisorDatastore: 'DC1-HYPRVSR01-DATA-03',
    },
  },
  networkZones:: {
    internal: {
      networkZoneNickName: 'int',
      nameServers: {
        // Cloudflare
        default: ['1.1.1.1', '1.0.0.1'],
      },
      urlBaseDomain: 'int.dc1.yourdomain.com',
    },
    dmz: {
      networkZoneNickName: 'dmz',
      nameServers: {
        // Google
        default: ['8.8.4.4', '8.8.8.8'],
      },
      urlBaseDomain: 'dmz.dc1.yourdomain.com',
    },
    integration: {
      networkZoneNickName: 'iz',
      nameServers: {
        // OpenDNS
        default: ['208.67.222.222', '208.67.220.220'],
      },
      urlBaseDomain: 'iz.dc1.yourdomain.com',
    },
  },

};

allClusters + datacenter
