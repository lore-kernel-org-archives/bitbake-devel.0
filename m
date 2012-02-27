Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S1vcq-0000Kj-Es
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 09:08:04 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 26 Feb 2012 23:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112155551"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 26 Feb 2012 23:59:35 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 15:58:09 +0800
Message-Id: <cover.1330329147.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1][PULL]: data_smart.py: use BB_HASH_WHITELIST as variable filter
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
X-List-Received-Date: Mon, 27 Feb 2012 08:08:04 -0000

Hi Richard,

This pull request changes the cache hash calculation method that uses BB_HASH_WHITELIST as variable filter.

Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 4d173d441d2beb8e6492b6b1842682f8cf32e6cc:

  V5 Disk space monitoring (2012-02-26 11:03:50 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/bitbake-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/bitbake-bugfix

Dongxiao Xu (1):
  data_smart.py: Uses BB_HASH_WHITELIST to filter unnecessary variables

 lib/bb/data_smart.py |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

-- 
1.7.4.1



