Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCAiA-0008Fp-Q8
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 16:15:55 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 26 Mar 2012 07:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123336887"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 26 Mar 2012 07:06:52 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 22:33:00 +0800
Message-Id: <cover.1332772309.git.shane.wang@intel.com>
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
X-List-Received-Date: Mon, 26 Mar 2012 14:15:55 -0000

These are some fixes for Hob.

The following changes since commit db529f9f7d9015656c67c548975d918a1908de1a:

  documentation/poky-ref-manual/development.xml: another env var clarification (2012-03-26 12:13:49 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob

Shane Wang (2):
  Hob: Set one of deployable images or runnable images as the default
    toggled item
  Hob: show (package, task) pair which is being executed on the build
    details screen

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   23 ++++++---
 bitbake/lib/bb/ui/crumbs/builder.py          |   12 +++-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   72 ++++++++++++++++---------
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |    7 +++
 4 files changed, 78 insertions(+), 36 deletions(-)

-- 
1.7.6



