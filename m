Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RkoYO-0005XF-Qw
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 04:08:44 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 10 Jan 2012 19:01:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105789848"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2012 19:01:12 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 11:03:19 +0800
Message-Id: <cover.1326249301.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/8 v2][PULL] Hob: bitbake related changes
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
X-List-Received-Date: Wed, 11 Jan 2012 03:08:45 -0000

Hi Richard,

This is the second pull request for Hob bitbake related changes.

Please help to reviewand pull.

Changes from v1:
1. Fixed a cache issue.
   If we run "source oe-init-env-setup", it will force to add POKY/bitbake/bin/ and POKY/scripts into PATH variable,
   which changes the configuration hash value. We handled this situation in the new code.
2. event.py: Change the parameter of PackageInfo events.
   We have a new approach to get all the available packages in the build repo,
   and here we change the way to pass the information.
3. Remove the binding limitation of --server-only and -B.

Thanks,
Dongxiao

The following changes since commit eac9249b40ae1e3aa21e016010c862664e59a8d4:
  Richard Purdie (1):
        bitbake: Add BBHandledException exception class

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib dxu4/hob-bitbake-changes-v2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bitbake-changes-v2

Dongxiao Xu (7):
  cache: Use configuration's hash value to validate cache
  command.py: add resolve option for generateTargetsTree API
  event.py: Add a new event PackageInfo
  bitbake: add -B option to bind with interface
  bitbake: Add client socket info for BitBakeServerConnection
  command.py: add new command to get the CPU info
  runqueue: fire sceneQueueTaskStarted event when a setscene queue
    starts

Shane Wang (1):
  Bitbake: change for adding progress bar in Hob2.

 bin/bitbake              |   15 +++++---
 bitbake/lib/bb/helper.py |   39 ++++++++++++++++++++
 lib/bb/cache.py          |   34 +++++++-----------
 lib/bb/command.py        |   23 +++++++++++-
 lib/bb/cooker.py         |   74 +++++++++++++++++++++++++++++--------
 lib/bb/data_smart.py     |   21 +++++++++++
 lib/bb/event.py          |   91 ++++++++++++++++++++++++++++++++++------------
 lib/bb/runqueue.py       |   10 +++++
 lib/bb/server/xmlrpc.py  |   10 +++---
 lib/bb/ui/knotty.py      |    5 ++-
 lib/bb/ui/uievent.py     |    7 ++--
 11 files changed, 253 insertions(+), 76 deletions(-)
 create mode 100644 bitbake/lib/bb/helper.py



