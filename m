Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SMb7J-00059l-JO
	for bitbake-devel@lists.openembedded.org;
	Tue, 24 Apr 2012 10:28:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 24 Apr 2012 01:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145178417"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 24 Apr 2012 01:19:21 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Apr 2012 16:16:09 +0800
Message-Id: <cover.1335254750.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/3][PULL] Hob: Fix bug 2361
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
X-List-Received-Date: Tue, 24 Apr 2012 08:28:57 -0000

Hi Richard,

This pull request is to fix bug 2361, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 244ce2b900ae6cecbeeccfe2056e61c132476261:

  hob: enable sanity checks after launch (2012-04-23 23:03:25 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (3):
  event.py: Add SanityCheck and SanityCheckPassed events
  Hob: Add proxy setting into setting's md5
  Hob: Issue sanity check after parse is completed

 lib/bb/event.py                     |   10 ++++++++++
 lib/bb/ui/crumbs/builder.py         |    7 +++++--
 lib/bb/ui/crumbs/hig.py             |    9 +++++++++
 lib/bb/ui/crumbs/hobeventhandler.py |   16 +++++++++++-----
 4 files changed, 35 insertions(+), 7 deletions(-)

-- 
1.7.4.1



