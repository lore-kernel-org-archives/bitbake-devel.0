Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SACY5-0002ph-Je
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 04:49:21 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 20 Mar 2012 20:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="142285667"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 20 Mar 2012 20:40:26 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 12:05:24 +0800
Message-Id: <cover.1332302662.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/5] Some small fixes for Hob
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
X-List-Received-Date: Wed, 21 Mar 2012 03:49:21 -0000

These are small fixes for Hob. Please review.

The following changes since commit 224ff370b4636cdd33c47c1e6341ef43a67e0227:

  xserver-kdrive: compile xserver without dtrace support (2012-03-20 15:21:39 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob2-v0.71
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.71

Shane Wang (5):
  Hob: Change window title from HOB to Hob
  Hob: Change "View Packages" description
  Hob: In the recipe view, change the headings
  Hob: In the package view, change the headings
  Hob: Change the titles for recipe view and package view

 bitbake/lib/bb/ui/crumbs/builder.py                |    2 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +++---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   12 ++++++------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.7.6



