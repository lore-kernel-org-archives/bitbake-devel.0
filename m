Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SIMPs-0000mu-0H
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 17:58:36 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Apr 2012 08:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="152855846"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2012 08:49:14 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 23:46:24 +0800
Message-Id: <cover.1334245432.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/3][PULL] Hob: Bug fixes
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
X-List-Received-Date: Thu, 12 Apr 2012 15:58:36 -0000

Hi Richard,

This pull request integrates your PoC into Hob. Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 3c2808b67384e92601cbd66877c36ca40df7c7ba:

  Hob: fix the missing functions (2012-04-12 15:56:42 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (3):
  command.py: Add a hook for config parsing
  Hob: Implement Hob config parse hook
  Hob: A minor fix on tooltip

 lib/bb/command.py                    |    7 +++++++
 lib/bb/parse/parse_py/ConfHandler.py |    5 +++++
 lib/bb/ui/crumbs/builder.py          |   26 ++++++++++++++++++++++++++
 lib/bb/ui/crumbs/hig.py              |    2 +-
 lib/bb/ui/crumbs/hobeventhandler.py  |   26 ++++++++++++++------------
 5 files changed, 53 insertions(+), 13 deletions(-)

-- 
1.7.4.1



