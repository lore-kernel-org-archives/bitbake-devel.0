Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZAN-0000bH-Sx
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 14:57:04 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Feb 2012 05:48:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="111194860"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Feb 2012 05:48:41 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 21:47:12 +0800
Message-Id: <cover.1330003017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/9][PULL] Hob2: bitbake related changes
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
X-List-Received-Date: Thu, 23 Feb 2012 13:57:04 -0000

Hi Richard,

This is the hob2 related bitbake changes. Please help to review and pull.

Compared with previous version:
 - cache.py: remove the DATE field and value in calculating self.configuration's hash value,
   which causes the cache invalid after one day.

Thanks,
Dongxiao

The following changes since commit 95a599067650902727ecb4a39d6dd003c5cfedf3:

  bitbake/ui/knotty: fix incorrect exit code (2012-02-22 21:30:18 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob2-bitbake-changes
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2-bitbake-changes

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

-- 
1.7.4.1



