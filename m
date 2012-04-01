Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SEJr3-00042E-2c
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 14:25:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Apr 2012 05:16:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="136234446"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2012 05:16:45 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  1 Apr 2012 20:14:08 +0800
Message-Id: <cover.1333269705.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 00/10][PULL] Hob: Bug fixes
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
X-List-Received-Date: Sun, 01 Apr 2012 12:25:57 -0000

Hi Richard,

This is the hob related bug fixes, please help to review and pull.

This version contains 5 commits that have been sent last time with no comments, and remove the two commits that Josh commented on.
Also there are another 5 commits for other bug fixes.

For the two patches that we are discussing, I didn't add them in this series. I will send a separate pull request for it after the decision is finalized.

Thanks,
Dongxiao

The following changes since commit 035e146ff92236a3eda71ad71e8389737f91753b:

  Hob: In building log page, fixed the issue about 'endpath' not clear when next to start build (2012-03-30 17:19:35 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (10):
  Hob: Fix MACHINE setting
  Hob: Update the cache when setting changed
  Hob: Remove some calling of initiate_new_build()
  Hob: Remove duplication for certain bitbake variables
  Hob: Set stop button sensitive after task started
  Hob: Remove the recipe/task type for multilib
  Hob: Fix toolchain build
  Hob: Check "dummy" image while update_image_combo
  Hob: Change base image to "Create your own image" if customized
  Hob: fix IMAGE_INSTALL setting while save template

 lib/bb/ui/crumbs/builddetailspage.py       |    2 +
 lib/bb/ui/crumbs/builder.py                |   22 ++++++++++----
 lib/bb/ui/crumbs/hobeventhandler.py        |   31 ++++++++++++--------
 lib/bb/ui/crumbs/hoblistmodel.py           |   43 ++++++++++++++++++++++-----
 lib/bb/ui/crumbs/imageconfigurationpage.py |   10 ++++++-
 lib/bb/ui/crumbs/imagedetailspage.py       |    2 -
 lib/bb/ui/crumbs/packageselectionpage.py   |    7 ++++
 lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +++
 8 files changed, 92 insertions(+), 30 deletions(-)

-- 
1.7.4.1



