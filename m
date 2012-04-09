Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SHAML-00076R-BK
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 10:54:01 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 09 Apr 2012 01:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="139394477"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2012 01:44:43 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 16:41:56 +0800
Message-Id: <cover.1333960654.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/6][PULL] Hob: Bug fixes
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
X-List-Received-Date: Mon, 09 Apr 2012 08:54:01 -0000

Hi Richard,

This pull request contains several Hob bug fixes, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit d49db15badb77855cef855ee73430fcbc16b6916:

  Hob: a minor fix on pmake (2012-04-05 18:47:37 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (6):
  Hob: Change base image to "Create your own image" if customized
  data_smart: Improve the calculation of config hash
  Hob: Fix the pattern patch for image name
  Hob: Fix tooltips in image configuration page
  Hob: Fix tooltips in Settings dialog
  Hob: Add an extra 50M space if zypper is selected

 lib/bb/data_smart.py                       |   10 +++++--
 lib/bb/ui/crumbs/builder.py                |    3 ++
 lib/bb/ui/crumbs/hig.py                    |   38 ++++++++++++++-------------
 lib/bb/ui/crumbs/imageconfigurationpage.py |   19 ++++++++------
 lib/bb/ui/crumbs/imagedetailspage.py       |    3 +-
 lib/bb/ui/crumbs/packageselectionpage.py   |    8 ++++++
 lib/bb/ui/crumbs/recipeselectionpage.py    |    7 ++++-
 7 files changed, 56 insertions(+), 32 deletions(-)

-- 
1.7.4.1



