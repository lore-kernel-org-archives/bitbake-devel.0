Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJ1Gz-0000y4-HW
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 13:36:09 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 14 Apr 2012 04:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141686702"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2012 04:26:45 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 14 Apr 2012 19:23:51 +0800
Message-Id: <cover.1334402345.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/4 v2][PULL] Hob: Bug fixes
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
X-List-Received-Date: Sat, 14 Apr 2012 11:36:09 -0000

Hi Richard,

This is the revised pull request contains several Hob related bug fixes, please help to review and pull.

Add some missed changes from v1:
1) Change the commit author for "Hob: A minor fix on tooltip".
2) Use BB_DEFAULT_TASK as parameter of generate_package().
3) Remove un-used function image_list_append().

Thanks,
Dongxiao

The following changes since commit 434fdb3913cc78e2e9cdeede4c4fa7f1c8ef8892:

  Hob: Added required packages for toolchain. (2012-04-13 12:00:12 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (3):
  Hob: Save the original image name into template
  Hob: Build selected image if not customized
  Hob: Use BB_DEFAULT_TASK as build task instead of hardcoded "build"

Richard Purdie (1):
  Hob: A minor fix on tooltip

 lib/bb/ui/crumbs/builder.py         |   38 +++++++++++++++++++++-------------
 lib/bb/ui/crumbs/hig.py             |    5 +++-
 lib/bb/ui/crumbs/hobeventhandler.py |   27 ++++++++++++++----------
 lib/bb/ui/crumbs/hoblistmodel.py    |   16 --------------
 4 files changed, 43 insertions(+), 43 deletions(-)

-- 
1.7.4.1



