Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SB6j6-0006kM-5q
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:48:28 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 08:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124330053"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 23 Mar 2012 08:39:30 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 00:01:49 +0800
Message-Id: <cover.1332518429.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Hob: fix 2098
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
X-List-Received-Date: Fri, 23 Mar 2012 15:48:28 -0000

This patch is to fix bug 2098 to make the build progress clear.

The following changes since commit 8350c03eeca3f5d70984797ef784f29c71cbbb3b:

  gst-plugins: remove obsolete orcc hack (2012-03-23 12:13:09 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob-fixes-1
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-1

Shane Wang (1):
  Hob: add build status labels in the build details screen to make it
    more close to the visual design

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   17 +++++++++++--
 bitbake/lib/bb/ui/crumbs/builder.py          |    3 ++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   33 +++++++++++++------------
 3 files changed, 34 insertions(+), 19 deletions(-)

-- 
1.7.6



