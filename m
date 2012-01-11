Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RkoZZ-0005q0-9e
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 04:09:57 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 10 Jan 2012 19:02:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="94565876"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 10 Jan 2012 19:02:26 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 11:04:41 +0800
Message-Id: <cover.1326250200.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1 v2][PULL] Hob: a new implementation for human oriented builder
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
X-List-Received-Date: Wed, 11 Jan 2012 03:09:57 -0000

Hi Richard,

This is the second pull request for hob new implementation.

Please help to review and pull.

Note this pull request has dependency on dxu4/hob-bitbake-changes-v2 and dxu4/hob-oecore-changes-v2.

Changes from v1:
1. Change according to the new package dump mechanism.

Thanks,
Dongxiao

The following changes since commit 1fd378dbf9689d3597cb15efe866f39ca4e3dfb7:
  Dongxiao Xu (1):
        runqueue: fire sceneQueueTaskStarted event when a setscene queue starts

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib dxu4/hob-v2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-v2

Dongxiao Xu (1):
  Hob: A new implemetation for Human Oriented Builder

 bitbake/lib/bb/ui/crumbs/advancedsetting.py  |  246 ++++
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |  524 ++++++++
 bitbake/lib/bb/ui/crumbs/layerselection.py   |  107 ++
 bitbake/lib/bb/ui/crumbs/packagelistmodel.py |  580 +++++++++
 bitbake/lib/bb/ui/crumbs/progressbar.py      |  184 +++
 bitbake/lib/bb/ui/crumbs/recipelistmodel.py  |  860 +++++++++++++
 bitbake/lib/bb/ui/crumbs/template.py         |  189 +++
 lib/bb/ui/crumbs/configurator.py             |  346 -----
 lib/bb/ui/crumbs/hobeventhandler.py          |  396 +++---
 lib/bb/ui/crumbs/hobprefs.py                 |  335 -----
 lib/bb/ui/crumbs/layereditor.py              |  153 ---
 lib/bb/ui/crumbs/progress.py                 |   20 -
 lib/bb/ui/crumbs/runningbuild.py             |   15 +-
 lib/bb/ui/crumbs/tasklistmodel.py            |  620 ---------
 lib/bb/ui/hob.py                             | 1731 ++++++++++++--------------
 lib/bb/ui/uihelper.py                        |   42 +
 16 files changed, 3735 insertions(+), 2613 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/advancedsetting.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hobwidget.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/layerselection.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/packagelistmodel.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/progressbar.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/recipelistmodel.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/template.py
 delete mode 100644 lib/bb/ui/crumbs/configurator.py
 delete mode 100644 lib/bb/ui/crumbs/hobprefs.py
 delete mode 100644 lib/bb/ui/crumbs/layereditor.py
 delete mode 100644 lib/bb/ui/crumbs/progress.py
 delete mode 100644 lib/bb/ui/crumbs/tasklistmodel.py
 mode change 100644 => 100755 lib/bb/ui/hob.py



