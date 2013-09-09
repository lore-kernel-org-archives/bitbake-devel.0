Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id A399C6BEC1
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:40:48 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 09 Sep 2013 09:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="357952728"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by azsmga001.ch.intel.com with ESMTP; 09 Sep 2013 09:40:48 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B8B8A560558; Mon,  9 Sep 2013 17:40:48 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:40:45 +0100
Message-Id: <cover.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/13] webhob related changes in bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 09 Sep 2013 16:40:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

I'm sending in a set of patches that bring in changes that prepare bitbake
for supporting WebHob-related tasks.

The changes focus on improving and standardizing the information sent through
the event system, and cleaning up code in bitbake.

The following changes since commit 0ca5d1fb38157564a2b9452ade32391d18a41b09:

  yocto-bsp: remove apm as a default MACHINE_FEATURE (2013-09-09 16:28:47 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/bitbake-core-changes-0909
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/bitbake-core-changes-0909

Alexandru DAMIAN (13):
  bitbake: cooker: clean up code and avoid duplication
  bitbake: runqueue: Add runQueueTaskSkipped event
  bitbake: runqueue: added prebuild detailed information
  bitbake: runqueue, build: event data change
  bitbake: runqueue: add sceneQueueTaskCompleted event
  bitbake: build: add link to logfile for Task events
  bitbake: cooker, command: add a command to return global data
  bitbake: cooker: use prepareTreeData when computing environment
  bitbake: event: do not abort on UI handlers error
  bitbake: add SinglePackageInfo event
  bitbake: event: adding an event to pass build file sizes
  bitbake: xmlrpc: delete unused code BitBakeUIEventServer
  bitbake: cooker: add extra recipe information

 bitbake/lib/bb/build.py         |  4 +++
 bitbake/lib/bb/command.py       |  7 ++++
 bitbake/lib/bb/cooker.py        | 74 +++++++++++++++++++++++++----------------
 bitbake/lib/bb/event.py         | 48 ++++++++++++++++++--------
 bitbake/lib/bb/runqueue.py      | 33 ++++++++++++++++--
 bitbake/lib/bb/server/xmlrpc.py | 45 -------------------------
 bitbake/lib/bb/ui/knotty.py     |  2 ++
 7 files changed, 123 insertions(+), 90 deletions(-)

-- 
1.8.1.2


