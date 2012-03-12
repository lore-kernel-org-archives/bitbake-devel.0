Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S751q-0005NJ-Uq
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Mar 2012 14:11:11 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 12 Mar 2012 06:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="116873742"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 12 Mar 2012 06:00:38 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Mar 2012 21:23:42 +0800
Message-Id: <cover.1331558220.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/3][V2] Hob Notebook Implementation
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
X-List-Received-Date: Mon, 12 Mar 2012 13:11:11 -0000

This patchset is to implement Hob self-defined notebook, and use it in the build details page.

The following changes since commit fe0659991b826eb3b4163743d29533fe5f91cb12:

  libx11-trim/diet: Ensure libx11-locale doesn't trigger multiple provider issues (2012-03-12 02:28:03 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob2-v0.69
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.69

Shane Wang (3):
  Hob: implement a self-defined notebook visual component for Hob
  Hob: use HobNotebook to implement a notebook in build details page
  Hob: show indicators on the tabs of the Hob notebook

 bitbake/lib/bb/ui/crumbs/builddetailspage.py     |   40 ++-
 bitbake/lib/bb/ui/crumbs/builder.py              |    5 +
 bitbake/lib/bb/ui/crumbs/hobcolor.py             |    1 +
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |  482 ++++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   19 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   19 +-
 bitbake/lib/bb/ui/crumbs/runningbuild.py         |   69 +++
 7 files changed, 518 insertions(+), 117 deletions(-)

-- 
1.7.6



