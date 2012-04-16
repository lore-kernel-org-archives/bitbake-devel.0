Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJlzw-0005h0-VR
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 15:29:41 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Apr 2012 06:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130139150"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 16 Apr 2012 06:20:14 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 21:17:17 +0800
Message-Id: <cover.1334582048.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/2][PULL] "__depends/__base_depends" ordering and config hash improvement
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
X-List-Received-Date: Mon, 16 Apr 2012 13:29:41 -0000

Hi Richard,

This pull request contains commits that:
1) Retain order of "__depends" and "__base_depends".
2) Improve the config hash calculation.

Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 98694c1dbc276cc151f393db67bfd43442da28ba:

  Hob: fixed a little view issue about package selection page (2012-04-16 12:56:15 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (2):
  bitbake: Retain order for __depends and __base_depends
  data_smart: Improve the calculation of config hash

 lib/bb/cache.py          |    6 ++++--
 lib/bb/cooker.py         |    6 ++++--
 lib/bb/data_smart.py     |    7 ++++---
 lib/bb/parse/__init__.py |   12 ++++++++----
 4 files changed, 20 insertions(+), 11 deletions(-)

-- 
1.7.4.1



