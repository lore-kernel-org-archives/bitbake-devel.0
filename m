Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SB6Gd-0005x7-D4
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:19:03 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 08:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="144030812"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 23 Mar 2012 08:10:06 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 23:07:48 +0800
Message-Id: <cover.1332514895.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/7][PULL] Hob: Bug fixes: image_types, runqemu/deploy filter
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
X-List-Received-Date: Fri, 23 Mar 2012 15:19:03 -0000

Hi Richard,

This pull request is for Hob related bug fixes, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 1119495cbfe2bd1ed0da630dc63f5860c1be73d4:

  lib/bb/ui/crumbs/builder: change dialogue title to Layers (2012-03-23 22:54:00 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (7):
  Hob: Remove unnecessary PARSE_BBFILES command
  Hob: Cleanup for hobeventhandler.py
  Hob: Initial an empty label in recipeselectionpage.py
  Hob: Change the Hob initialization process
  Hob: Fix the workaround to get image types
  Hob: Add a supported image type "vmdk"
  Hob: runqemu and deployment functionality filter

 lib/bb/ui/crumbs/builder.py             |   20 +++++--
 lib/bb/ui/crumbs/hobeventhandler.py     |   90 ++++++++++++++-----------------
 lib/bb/ui/crumbs/hobwidget.py           |    1 +
 lib/bb/ui/crumbs/imagedetailspage.py    |   44 +++++++++++----
 lib/bb/ui/crumbs/recipeselectionpage.py |    2 +-
 lib/bb/ui/hob.py                        |    2 -
 6 files changed, 89 insertions(+), 70 deletions(-)

-- 
1.7.4.1



