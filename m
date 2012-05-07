Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SRHKc-00009M-9d
	for bitbake-devel@lists.openembedded.org;
	Mon, 07 May 2012 08:22:02 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 06 May 2012 23:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="162778138"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 06 May 2012 23:12:11 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 May 2012 14:08:34 +0800
Message-Id: <cover.1336370732.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1][PULL][1.2.1] Hob: Fix bug 2371
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
X-List-Received-Date: Mon, 07 May 2012 06:22:02 -0000

Hi Richard and Scott,

This pull request is to fix yocto bug 2371. Both for upstream and 1.2.1 branch.
Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit ac9f8536bdae2f6bf6ef1c4b8e98c590842be40b:

  bitbake/tests: Add missing __init__.py file (2012-05-04 17:42:28 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (1):
  Hob: Clear the building status if command failed

 lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

-- 
1.7.4.1



