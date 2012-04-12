Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SIKat-00075Q-Ts
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 16:01:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 12 Apr 2012 06:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="131618750"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 12 Apr 2012 06:52:30 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 22:19:10 +0800
Message-Id: <cover.1334240256.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Hob fixes
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
X-List-Received-Date: Thu, 12 Apr 2012 14:01:52 -0000

The two patche are going to fix:
 - Hob can not be launched because a function is missing when being merged.
 - Walkaround for exit Hob issue when Hob is parsing recipes.

The following changes since commit 58d2ff3955f5ab8712516651ad6cc51d86bc1ba1:

  package_rpm.bbclass: Use the correct macros file to avoid empty solvedb path issues (2012-04-12 08:22:00 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob_0412
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob_0412

Shane Wang (2):
  Hob: fix the missing functions
  Hob: forbid users to exit Hob directly when Hob is busy

 bitbake/lib/bb/ui/crumbs/builder.py              |    6 ++++++
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
1.7.6



