Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rlcc6-0002P7-3w
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 09:35:54 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Jan 2012 00:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="106715918"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2012 00:28:20 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 16:30:34 +0800
Message-Id: <cover.1326442655.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/9 v3][PULL] Hob: bitbake related changes
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
X-List-Received-Date: Fri, 13 Jan 2012 08:35:54 -0000

Hi Richard,

This is the third pull request for Hob bitbake related changes.

Please help to review and pull.

Changes from v2:
1. Fix parameter checking issue on --bind and --server-only.
2. Add a new command triggerEvent(), which enables the client to request triggering specific event from bitbake server.
3. Add a specific event 'RequestPackageInfo' to get available package information.
4. Change the way to get the CPU information on server side.

Thanks,
Dongxiao

The following changes since commit 9d8f45407c67ed0d3c4f820cf646de3c385067c7:
  Lianhao Lu (1):
        bitbake: Automatically start local PR service.

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib dxu4/hob-bitbake-changes-v3
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bitbake-changes-v3

Dongxiao Xu (7):
  cache: Use configuration's hash value to validate cache
  command.py: add resolve option for generateTargetsTree API
  event.py: Add new events RequestPackageInfo and PackageInfo
  bitbake: add -B option to bind with interface
  bitbake: Add client socket info for BitBakeServerConnection
  command.py: Add a new API triggerEvent()
  runqueue: fire sceneQueueTaskStarted event when a setscene queue
    starts

Shane Wang (2):
  bitbake: change for adding progress bar in Hob2.
  command.py: add new API to get the cpu count on the server

 bin/bitbake             |   17 +++++++-
 lib/bb/cache.py         |   34 ++++++----------
 lib/bb/command.py       |   23 ++++++++++-
 lib/bb/cooker.py        |   74 ++++++++++++++++++++++++++++--------
 lib/bb/data_smart.py    |   21 ++++++++++
 lib/bb/event.py         |   96 +++++++++++++++++++++++++++++++++++-----------
 lib/bb/runqueue.py      |   10 +++++
 lib/bb/server/xmlrpc.py |   10 ++--
 lib/bb/ui/knotty.py     |    5 ++-
 lib/bb/ui/uievent.py    |    7 ++-
 lib/bb/utils.py         |    4 ++
 11 files changed, 227 insertions(+), 74 deletions(-)



