Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5mJ-0007N1-BY
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:07:59 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 06 Jan 2012 01:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="104155203"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2012 01:00:34 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:18 +0800
Message-Id: <cover.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 00/16][PULL] Hob2 related bitbake changes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Jan 2012 09:07:59 -0000

Hi Richard,

This pull request is the hob2 related bitbake changes.
Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit bc954f74620959703a0e921fcac3a6892675fe0d:
  Richard Purdie (1):
        cooker.py: Add missing BB_WORKERCONTEXT conditionals

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib dxu4/hob-bitbake-changes
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bitbake-changes

Dongxiao Xu (15):
  command.py: Modify needcache value for certain functions
  cache: Use configuration's hash value to validate cache
  cooker: user bb.configuration.data to inject events
  command.py: add initCooker API
  command.py: add parseConfigurationFiles API
  command.py: add resolve option for generateTargetsTree API
  event.py: Add a new event PackageInfo
  xmlrpc: Change BitbakeServerInfo init function
  cooker: remove command import in cooker.py
  bitbake: add a new option "--server-only"
  bitbake: add -B option to bind with interface
  bitbake: Add client socket info for BitBakeServerConnection
  command.py: add a new API findCoreBaseFiles
  command.py: add new command to get the CPU info
  runqueue: fire sceneQueueTaskStarted event when a setscene queue
    starts

Shane Wang (1):
  Bitbake: change for adding progress bar in Hob2.

 bin/bitbake              |   34 +++++++++++----
 bitbake/lib/bb/helper.py |   39 +++++++++++++++++
 lib/bb/cache.py          |   34 ++++++---------
 lib/bb/command.py        |   54 ++++++++++++++++++++++--
 lib/bb/cooker.py         |  105 +++++++++++++++++++++++++++++++++++++--------
 lib/bb/data_smart.py     |   17 +++++++
 lib/bb/event.py          |  100 +++++++++++++++++++++++++++++++++----------
 lib/bb/runqueue.py       |   10 ++++
 lib/bb/server/xmlrpc.py  |   18 ++++----
 lib/bb/ui/knotty.py      |    5 ++-
 lib/bb/ui/uievent.py     |    7 ++-
 11 files changed, 334 insertions(+), 89 deletions(-)
 create mode 100644 bitbake/lib/bb/helper.py



