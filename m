Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Fj-0006FM-P1
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:41:43 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 15 Mar 2012 01:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121224373"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 15 Mar 2012 01:31:56 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:48 +0800
Message-Id: <cover.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 00/12 v2][PULL] Hob: Functionality and GUI Fixes
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
X-List-Received-Date: Thu, 15 Mar 2012 08:41:44 -0000

Hi Richard,

This is the second pull request for Hob functionality and GUI fixes, please help to review and pull.

Changes from v1:
1) Modify the Box padding according to Josh's comments.
2) Add a new patch which fixes all Box's padding values in Hob code.

Thanks,
Dongxiao

The following changes since commit 2d56dc7b1f0d186e14c4c8a949b280b6b3fc31de:

  codeparser: Call intern over the set contents for better cache performance (2012-03-12 02:22:34 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (12):
  Hob: add "Close" button to "BinbDialog"
  Hob: Disable the handling of "NoProvider" event
  cooker: add package rdepends and rrecommends info
  Hob: Fix the image installation dependency
  Hob: Remove the reset button in recipe/package selection page
  Hob: Remove the indication in machine/base image combobox
  Hob: Remove the recipe/package populated signal
  Hob: Show recipe/package editing button after base image is selected
  Hob: Emit command-failed signal even if error msg is None
  Hob: Add stop button for parsing progress
  Hob: improve recipe/package selection performance
  Hob: Change Box's padding value

 lib/bb/cooker.py                           |    4 +-
 lib/bb/ui/crumbs/builddetailspage.py       |    6 +-
 lib/bb/ui/crumbs/builder.py                |   68 +++++++++++++++++----------
 lib/bb/ui/crumbs/hig.py                    |   18 ++++----
 lib/bb/ui/crumbs/hobeventhandler.py        |   43 ++++++++++--------
 lib/bb/ui/crumbs/hoblistmodel.py           |   32 +++-----------
 lib/bb/ui/crumbs/hobpages.py               |    2 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |   50 ++++++++++++++-------
 lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 lib/bb/ui/crumbs/packageselectionpage.py   |   14 +-----
 lib/bb/ui/crumbs/recipeselectionpage.py    |   12 +----
 11 files changed, 128 insertions(+), 123 deletions(-)

-- 
1.7.4.1



