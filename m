Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SK2qZ-00048K-J8
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 09:29:09 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Apr 2012 00:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="133350996"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 17 Apr 2012 00:19:40 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Apr 2012 15:16:41 +0800
Message-Id: <cover.1334646853.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/3 v2][PULL] "__depends/__base_depends" ordering, config hash improvement, and Hob fix
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
X-List-Received-Date: Tue, 17 Apr 2012 07:29:09 -0000

Hi Richard,

This is the second pull request for some Hob and Bitbake bug fixes, please help to review and pull.

This pull request contains commits that:
1) Retain order of "__depends" and "__base_depends".
2) Improve the config hash calculation.
3) Enlarge the upper value for image size spinner.

Changes from v1:
Add a new commit that enlarges the upper value for image size spinner.

Thanks,
Dongxiao

The following changes since commit 98694c1dbc276cc151f393db67bfd43442da28ba:

  Hob: fixed a little view issue about package selection page (2012-04-16 12:56:15 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (3):
  bitbake: Retain order for __depends and __base_depends
  data_smart: Improve the calculation of config hash
  Hob: Enlarge the upper value of image size

 lib/bb/cache.py          |    6 ++++--
 lib/bb/cooker.py         |    6 ++++--
 lib/bb/data_smart.py     |    7 ++++---
 lib/bb/parse/__init__.py |   12 ++++++++----
 lib/bb/ui/crumbs/hig.py  |    8 ++++----
 5 files changed, 24 insertions(+), 15 deletions(-)

-- 
1.7.4.1



