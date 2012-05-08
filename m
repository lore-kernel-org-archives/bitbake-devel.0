Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SRj18-0005Nc-2t
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 May 2012 13:55:47 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 May 2012 04:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="141367968"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 08 May 2012 04:45:52 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 May 2012 19:48:01 +0800
Message-Id: <cover.1336477313.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/4] Hob: bug-fixes
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
X-List-Received-Date: Tue, 08 May 2012 11:55:48 -0000

The following changes since commit 38da655788361e949d605bebfab45cf5830df613:

  glib-2.0: Fix issues with libelf dependency creeping in (2012-05-07 16:42:48 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (4):
  Hob: change the refresh icon speed to make it view clear
  Hob: add original url show function with the tooltip hyperlink for
    user
  Hob: add group number show and 'bold' visible effect for Package view
  Hob: change the workflow about click 'Run Image' to run directly
    after builded a qemu image

 bitbake/lib/bb/ui/crumbs/builder.py              |   52 ++++++---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    7 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |   41 ++++++-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |  139 +++++++++++-----------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   26 ++++
 bitbake/lib/bb/ui/crumbs/persistenttooltip.py    |   19 +++
 6 files changed, 194 insertions(+), 90 deletions(-)

-- 
1.7.5.4



