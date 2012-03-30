Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDahF-00034F-Ow
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 14:12:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 30 Mar 2012 05:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="135675564"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2012 05:03:42 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 20:01:12 +0800
Message-Id: <cover.1333108781.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/7][PULL] Hob: Bug fixes
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
X-List-Received-Date: Fri, 30 Mar 2012 12:12:50 -0000

Hi Richard,

This pull request is some Hob related bug fixes, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 8fed4fdf4bbbc9ef036ff96755c0bfe15c3a9dd0:

  knotty: Add back getTasks() call to ensure we don't repeat messges (2012-03-29 21:38:25 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (7):
  Hob: Fix MACHINE setting
  Hob: Update the cache when setting changed
  Hob: Make layers define in bblayers.conf as default
  Revert "lib/bb/ui/crumbs/hig: fix layers_changed test"
  Hob: Remove some calling of initiate_new_build()
  Hob: Remove duplication for certain bitbake variables
  Hob: Set stop button sensitive after task started

 lib/bb/ui/crumbs/builddetailspage.py |    2 ++
 lib/bb/ui/crumbs/builder.py          |   10 +++++-----
 lib/bb/ui/crumbs/hig.py              |   28 ++++++++++------------------
 lib/bb/ui/crumbs/hobeventhandler.py  |   22 +++++++++++++++-------
 lib/bb/ui/crumbs/imagedetailspage.py |    2 --
 5 files changed, 32 insertions(+), 32 deletions(-)

-- 
1.7.4.1



