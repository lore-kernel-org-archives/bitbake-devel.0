Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SKNun-0004RC-K4
	for bitbake-devel@lists.openembedded.org;
	Wed, 18 Apr 2012 07:58:53 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 17 Apr 2012 22:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132238548"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 17 Apr 2012 22:49:24 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Apr 2012 13:46:26 +0800
Message-Id: <cover.1334727847.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1][PULL] bitbake: retain order for __depends and __base_depends variables
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
X-List-Received-Date: Wed, 18 Apr 2012 05:58:53 -0000

Hi Richard,

This is the revised version for retaining order for __depends and __base_depends variables,
please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 1a39698ab8498410d159c665c015f9297f153797:

  lib/bb/ui/crumbs/recipeselectionpage: fix type availabel->available (2012-04-17 16:41:30 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (1):
  bitbake: Retain order for __depends and __base_depends

 lib/bb/cache.py          |   15 +++++++++++----
 lib/bb/cooker.py         |    4 ++--
 lib/bb/parse/__init__.py |    8 ++++----
 3 files changed, 17 insertions(+), 10 deletions(-)

-- 
1.7.4.1



