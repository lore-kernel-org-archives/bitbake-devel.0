Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S21rJ-00036O-Mc
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 15:47:25 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 27 Feb 2012 06:38:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="111271886"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 27 Feb 2012 06:38:57 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 22:37:31 +0800
Message-Id: <cover.1330353017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1 v2][PULL] data_smart.py: use BB_HASH_WHITELIST as variable filter
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
X-List-Received-Date: Mon, 27 Feb 2012 14:47:25 -0000

Hi Richard,

This pull request changes the cache hash calculation method that uses BB_HASHCONFIG_WHITELIST as variable filter.

Please help to review and pull.

Changes from v1:
Use another variable named BB_HASHCONFIG_WHITELIST as the filter instead of BB_HASHBASE_WHITELIST

Thanks,
Dongxiao

The following changes since commit 4d173d441d2beb8e6492b6b1842682f8cf32e6cc:

  V5 Disk space monitoring (2012-02-26 11:03:50 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/bitbake-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/bitbake-bugfix

Dongxiao Xu (1):
  data_smart.py: Uses BB_HASHCONFIG_WHITELIST to filter unnecessary
    variables

 lib/bb/data_smart.py |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

-- 
1.7.4.1



