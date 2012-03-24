Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBPeA-0003RD-6L
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 13:00:38 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 24 Mar 2012 04:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121209022"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 24 Mar 2012 04:51:39 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 19:49:18 +0800
Message-Id: <cover.1332589589.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/9 v3][PULL] Hob: Bug fixes: image_types, runqemu/deploy functionality filter, and DISTRO setting
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
X-List-Received-Date: Sat, 24 Mar 2012 12:00:38 -0000

Hi Richard,

This is the third pull request for Hob bug fixes, please help to review and pull.

Changes from v2:
1) Change the logic in set_distro(), that is, if defaultsetup is selected in Hob advanced setting dialog, we should leave DISTRO variable not set in bitbake server.
2) Add a new patch to avoid hardcode TMPDIR when executing runqemu.

Thanks,
Dongxiao

The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:

  Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (9):
  Hob: Remove unnecessary PARSE_BBFILES command
  Hob: Cleanup for hobeventhandler.py
  Hob: Initial an empty label in recipeselectionpage.py
  Hob: Change the Hob initialization process
  Hob: Fix the workaround to get image types
  Hob: Add a supported image type "vmdk"
  Hob: runqemu and deployment functionality filter
  Hob: Set empty DISTRO if "defaultsetup" is selected
  Hob: Avoid getting TMPDIR in hardcode

 lib/bb/ui/crumbs/builder.py             |   23 +++++--
 lib/bb/ui/crumbs/hobeventhandler.py     |   94 ++++++++++++++-----------------
 lib/bb/ui/crumbs/hobwidget.py           |    1 +
 lib/bb/ui/crumbs/imagedetailspage.py    |   44 +++++++++++----
 lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 lib/bb/ui/hob.py                        |    2 -
 6 files changed, 94 insertions(+), 72 deletions(-)

-- 
1.7.4.1



