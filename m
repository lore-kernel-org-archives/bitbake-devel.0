Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj64l-0008Gm-1P
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:27:03 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 06 Jan 2012 01:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="95124078"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga002.jf.intel.com with ESMTP; 06 Jan 2012 01:19:37 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:21:37 +0800
Message-Id: <cover.1325841596.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1][PULL] hob: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Fri, 06 Jan 2012 09:27:03 -0000

Hi Richard,

This pull request is a new implementation for hob.
Please help to review and pull.

Note that this change has dependency on hob-bitbake-changes and hob-oecore-changes.

Thanks,
Dongxiao

The following changes since commit c9c075648019ee0f55b2ed916b40567307cd5674:
  Dongxiao Xu (1):
        runqueue: fire sceneQueueTaskStarted event when a setscene queue starts

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib dxu4/hob
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob

Dongxiao Xu (1):
  Hob2: A new implemetation for Human Oriented Builder

 bitbake/lib/bb/ui/crumbs/advancedsetting.py  |  246 ++++
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |  524 ++++++++
 bitbake/lib/bb/ui/crumbs/layerselection.py   |  107 ++
 bitbake/lib/bb/ui/crumbs/packagelistmodel.py |  552 ++++++++
 bitbake/lib/bb/ui/crumbs/progressbar.py      |  184 +++
 bitbake/lib/bb/ui/crumbs/recipelistmodel.py  |  860 +++++++++++++
 bitbake/lib/bb/ui/crumbs/template.py         |  189 +++
 lib/bb/ui/crumbs/configurator.py             |  346 -----
 lib/bb/ui/crumbs/hobeventhandler.py          |  392 +++---
 lib/bb/ui/crumbs/hobprefs.py                 |  335 -----
 lib/bb/ui/crumbs/layereditor.py              |  153 ---
 lib/bb/ui/crumbs/progress.py                 |   20 -
 lib/bb/ui/crumbs/runningbuild.py             |   15 +-
 lib/bb/ui/crumbs/tasklistmodel.py            |  620 ---------
 lib/bb/ui/hob.py                             | 1736 ++++++++++++--------------
 lib/bb/ui/uihelper.py                        |   42 +
 16 files changed, 3716 insertions(+), 2605 deletions(-)
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



