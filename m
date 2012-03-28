Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCvai-0005xU-RG
	for bitbake-devel@lists.openembedded.org;
	Wed, 28 Mar 2012 18:19:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2012 09:10:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126153857"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2012 09:10:14 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 00:36:49 +0800
Message-Id: <cover.1332952559.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/5] Hob: bug fixes
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
X-List-Received-Date: Wed, 28 Mar 2012 16:19:21 -0000

Fix bug 2163 and some words

The following changes since commit bbef66e4005def54d70d3720ec131fa7edc22e2a:

  Hob: allow users to setup the proxies (2012-03-28 15:57:39 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob-fixes-2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-2

Shane Wang (5):
  Hob: add Templates and Settings on image details screen
  Hob: change some words for build configurations on build details
    screen
  Hob: change some words on image configuration screen to make them
    consistent
  Hob: change some words on recipes screen and package screen to make
    them consistent
  Hob: change some words in settings dialog to make them consistent

 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   22 +++++++-------
 bitbake/lib/bb/ui/crumbs/builder.py                |   19 ++++++++-----
 bitbake/lib/bb/ui/crumbs/hig.py                    |   22 +++++++-------
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   18 +++++++++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   29 ++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    4 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    6 ++--
 7 files changed, 81 insertions(+), 39 deletions(-)

-- 
1.7.6



