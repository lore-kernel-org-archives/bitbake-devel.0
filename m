Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S7ke3-0008CI-JB
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Mar 2012 10:37:23 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 14 Mar 2012 02:28:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="128813628"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 14 Mar 2012 02:28:37 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Mar 2012 17:26:31 +0800
Message-Id: <cover.1331716896.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 00/11][PULL] Hob: Functionality and GUI fixes
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
X-List-Received-Date: Wed, 14 Mar 2012 09:37:23 -0000

Hi Richard,

This pull request is a bunch of fixes to the new Hob, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 2d56dc7b1f0d186e14c4c8a949b280b6b3fc31de:

  codeparser: Call intern over the set contents for better cache performance (2012-03-12 02:22:34 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (11):
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

 lib/bb/cooker.py                           |    4 +-
 lib/bb/ui/crumbs/builder.py                |   68 +++++++++++++++++----------
 lib/bb/ui/crumbs/hig.py                    |    4 +-
 lib/bb/ui/crumbs/hobeventhandler.py        |   43 ++++++++++--------
 lib/bb/ui/crumbs/hoblistmodel.py           |   32 +++-----------
 lib/bb/ui/crumbs/imageconfigurationpage.py |   48 +++++++++++++------
 lib/bb/ui/crumbs/packageselectionpage.py   |   12 +-----
 lib/bb/ui/crumbs/recipeselectionpage.py    |   10 +----
 8 files changed, 113 insertions(+), 108 deletions(-)

-- 
1.7.4.1



