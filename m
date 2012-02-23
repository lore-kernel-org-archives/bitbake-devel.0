Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZBi-0000qe-0F
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 14:58:27 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Feb 2012 05:50:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="120527947"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2012 05:50:02 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 21:48:41 +0800
Message-Id: <cover.1330004101.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1][PULL] Hob2: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Thu, 23 Feb 2012 13:58:27 -0000

Hi Richard,

This pull request is a new implementation for Human Oriented Builder, please help to review and pull.

Changes from previous pull requests:
 - Re-implemented a lot of code according to Belen's new GUI design.

Note that this pull request depends on the following pull requests:
 - hob2-bitbake-changes
 - hob2-oecore-changes

Thanks,
Dongxiao


The following changes since commit cec8b6e6c33582be660dd35c6050efc3f28e6baa:

  runqueue: fire sceneQueueTaskStarted event when a setscene queue starts (2012-02-23 21:04:49 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2

Dongxiao Xu (1):
  Hob: A new implemetation for Human Oriented Builder

 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |  110 ++
 bitbake/lib/bb/ui/crumbs/builder.py                |  873 +++++++++++++++
 bitbake/lib/bb/ui/crumbs/hobcolor.py               |   35 +
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |  765 ++++++++++++++
 bitbake/lib/bb/ui/crumbs/hobpages.py               |   87 ++
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |  805 ++++++++++++++
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |  358 +++++++
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  294 +++++
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |  226 ++++
 bitbake/lib/bb/ui/crumbs/progressbar.py            |   52 +
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |  221 ++++
 bitbake/lib/bb/ui/crumbs/template.py               |  180 ++++
 bitbake/lib/bb/ui/icons/images/images_display.png  |  Bin 0 -> 6898 bytes
 bitbake/lib/bb/ui/icons/images/images_hover.png    |  Bin 0 -> 7051 bytes
 bitbake/lib/bb/ui/icons/indicators/alert.png       |  Bin 0 -> 3954 bytes
 .../lib/bb/ui/icons/indicators/confirmation.png    |  Bin 0 -> 5789 bytes
 bitbake/lib/bb/ui/icons/indicators/denied.png      |  Bin 0 -> 3955 bytes
 bitbake/lib/bb/ui/icons/indicators/error.png       |  Bin 0 -> 6482 bytes
 bitbake/lib/bb/ui/icons/indicators/issues.png      |  Bin 0 -> 4549 bytes
 bitbake/lib/bb/ui/icons/indicators/refresh.png     |  Bin 0 -> 5250 bytes
 bitbake/lib/bb/ui/icons/indicators/tick.png        |  Bin 0 -> 4563 bytes
 bitbake/lib/bb/ui/icons/info/info_display.png      |  Bin 0 -> 4760 bytes
 bitbake/lib/bb/ui/icons/info/info_hover.png        |  Bin 0 -> 4847 bytes
 bitbake/lib/bb/ui/icons/layers/layers_display.png  |  Bin 0 -> 5326 bytes
 bitbake/lib/bb/ui/icons/layers/layers_hover.png    |  Bin 0 -> 5390 bytes
 .../lib/bb/ui/icons/packages/packages_display.png  |  Bin 0 -> 7188 bytes
 .../lib/bb/ui/icons/packages/packages_hover.png    |  Bin 0 -> 7308 bytes
 bitbake/lib/bb/ui/icons/recipe/recipe_display.png  |  Bin 0 -> 4873 bytes
 bitbake/lib/bb/ui/icons/recipe/recipe_hover.png    |  Bin 0 -> 5003 bytes
 .../lib/bb/ui/icons/settings/settings_display.png  |  Bin 0 -> 6076 bytes
 .../lib/bb/ui/icons/settings/settings_hover.png    |  Bin 0 -> 6269 bytes
 .../bb/ui/icons/templates/templates_display.png    |  Bin 0 -> 5651 bytes
 .../lib/bb/ui/icons/templates/templates_hover.png  |  Bin 0 -> 5791 bytes
 lib/bb/ui/crumbs/configurator.py                   |  346 ------
 lib/bb/ui/crumbs/hig.py                            |  589 ++++++++++-
 lib/bb/ui/crumbs/hobeventhandler.py                |  586 ++++++----
 lib/bb/ui/crumbs/hobprefs.py                       |  335 ------
 lib/bb/ui/crumbs/layereditor.py                    |  153 ---
 lib/bb/ui/crumbs/progress.py                       |   20 -
 lib/bb/ui/crumbs/runningbuild.py                   |   55 +-
 lib/bb/ui/crumbs/tasklistmodel.py                  |  620 -----------
 lib/bb/ui/hob.py                                   | 1115 +-------------------
 lib/bb/ui/uihelper.py                              |   42 +
 43 files changed, 5065 insertions(+), 2802 deletions(-)
 create mode 100755 bitbake/lib/bb/ui/crumbs/builddetailspage.py
 create mode 100755 bitbake/lib/bb/ui/crumbs/builder.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hobcolor.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hoblistmodel.py
 create mode 100755 bitbake/lib/bb/ui/crumbs/hobpages.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hobwidget.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
 create mode 100755 bitbake/lib/bb/ui/crumbs/imagedetailspage.py
 create mode 100755 bitbake/lib/bb/ui/crumbs/packageselectionpage.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/progressbar.py
 create mode 100755 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/template.py
 create mode 100644 bitbake/lib/bb/ui/icons/images/images_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/images/images_hover.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/alert.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/confirmation.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/denied.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/error.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/issues.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/refresh.png
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/tick.png
 create mode 100644 bitbake/lib/bb/ui/icons/info/info_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/info/info_hover.png
 create mode 100644 bitbake/lib/bb/ui/icons/layers/layers_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/layers/layers_hover.png
 create mode 100644 bitbake/lib/bb/ui/icons/packages/packages_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/packages/packages_hover.png
 create mode 100644 bitbake/lib/bb/ui/icons/recipe/recipe_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/recipe/recipe_hover.png
 create mode 100644 bitbake/lib/bb/ui/icons/settings/settings_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/settings/settings_hover.png
 create mode 100644 bitbake/lib/bb/ui/icons/templates/templates_display.png
 create mode 100644 bitbake/lib/bb/ui/icons/templates/templates_hover.png
 delete mode 100644 lib/bb/ui/crumbs/configurator.py
 delete mode 100644 lib/bb/ui/crumbs/hobprefs.py
 delete mode 100644 lib/bb/ui/crumbs/layereditor.py
 delete mode 100644 lib/bb/ui/crumbs/progress.py
 delete mode 100644 lib/bb/ui/crumbs/tasklistmodel.py
 mode change 100644 => 100755 lib/bb/ui/hob.py

-- 
1.7.4.1



