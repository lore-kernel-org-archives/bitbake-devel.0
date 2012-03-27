Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SCbC4-0005fh-PR
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 20:32:33 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 27 Mar 2012 11:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123927690"
Received: from hp.sh.intel.com ([10.239.47.1])
	by azsmga001.ch.intel.com with ESMTP; 27 Mar 2012 11:23:29 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2012 02:25:40 +0800
Message-Id: <cover.1332871932.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/6] [V2] Hob: bug fixes
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
X-List-Received-Date: Tue, 27 Mar 2012 18:32:33 -0000

The following changes since commit 7b01671f54f70c28c98457058c51ffefcb07c0e8:

  nspr 4.8.9: failed to build on x86_64 board (2012-03-27 13:26:37 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (6):
  Hob: add refresh icon as ui request in building log
  Hob: fixed visually differentiate warnings and errors icon in
    building log
  Hob: change the recipe pasing error dialog icon from 'dialog-info' to
    'dialog-error'
  Hob: use hob icon checker to check the gtk icon for make the icon
    constaintly
  Hob: change the implementing way about get config info for building
    log
  Hob: fixed some not compatible places for make runningbuild.py can be
    reused by another application

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   88 +++++++++++-
 bitbake/lib/bb/ui/crumbs/builder.py          |    9 +-
 bitbake/lib/bb/ui/crumbs/hig.py              |    8 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    6 +
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |  196 ++++++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   64 ++++-----
 6 files changed, 324 insertions(+), 47 deletions(-)

-- 
1.7.5.4



