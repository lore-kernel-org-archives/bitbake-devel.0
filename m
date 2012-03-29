Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDf-0007OZ-S0
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:48 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 29 Mar 2012 05:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="83037915"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 29 Mar 2012 05:03:42 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:06 +0800
Message-Id: <cover.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 00/14][PULL] Hob: Bugfix and feature enhancement
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:48 -0000

Hi Richard,

This pull request contains Hob related bug fixes and enhancement.
Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit f9cf2671c0ecad153db11bca1aebe151213bfb42:

  bb.build: use relative log links, not absolute (2012-03-28 22:28:00 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (14):
  Hob: Remove un-used signal and functions
  Hob: Fix adding duplicated meta-hob layer
  Hob: Define a variable to store the image name and toolchain
  Hob: Improve the matching for runnable machine type
  command.py: Move triggerEvent to command async class
  Hob: Improve for init a new build
  Hob: Fix MACHINE setting
  Hob: Inherit image_types.bbclass in set_user_config()
  Hob: Update configuration after parsing
  Hob: Remember user settings when reparse config
  Hob: Update the cache when setting changed
  Hob: Change the format to store image_fstype variable
  Hob: Fix the setting hash calculation
  Hob: Replace "local.conf" in error message

 lib/bb/command.py                    |   17 +++++----
 lib/bb/ui/crumbs/builder.py          |   65 ++++++++++++++++++++++++---------
 lib/bb/ui/crumbs/hig.py              |   40 ++++++++++++---------
 lib/bb/ui/crumbs/hobeventhandler.py  |   34 ++++++++----------
 lib/bb/ui/crumbs/imagedetailspage.py |    3 +-
 5 files changed, 97 insertions(+), 62 deletions(-)

-- 
1.7.4.1



