Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBJzp-0006sz-Oe
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 06:58:37 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 22:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144560211"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2012 22:49:39 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 13:47:18 +0800
Message-Id: <cover.1332567775.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/8 v2][PULL] Hob: Bug fixes: image_types, runqemu/deploy functionality filter, and DISTRO setting
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
X-List-Received-Date: Sat, 24 Mar 2012 05:58:38 -0000

Hi Richard,

This is the second pull request for Hob bug fixes, please help to review and pull.

Changes from v1:
1) Rebased to latest master.
2) Added a new patch "Hob: Set empty DISTRO if "defaultsetup" is selected" that fixed the multiple inclusion of defaultsetup.conf. This could solve the problem Eric Benard reported in mailing list.

Thanks,
Dongxiao

The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:

  Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (8):
  Hob: Remove unnecessary PARSE_BBFILES command
  Hob: Cleanup for hobeventhandler.py
  Hob: Initial an empty label in recipeselectionpage.py
  Hob: Change the Hob initialization process
  Hob: Fix the workaround to get image types
  Hob: Add a supported image type "vmdk"
  Hob: runqemu and deployment functionality filter
  Hob: Set empty DISTRO if "defaultsetup" is selected

 lib/bb/ui/crumbs/builder.py             |   20 +++++--
 lib/bb/ui/crumbs/hobeventhandler.py     |   92 ++++++++++++++-----------------
 lib/bb/ui/crumbs/hobwidget.py           |    1 +
 lib/bb/ui/crumbs/imagedetailspage.py    |   44 +++++++++++----
 lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 lib/bb/ui/hob.py                        |    2 -
 6 files changed, 91 insertions(+), 70 deletions(-)

-- 
1.7.4.1



