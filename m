Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SC7Ty-00005A-1K
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 12:49:02 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Mar 2012 03:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145464381"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2012 03:38:56 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 18:41:05 +0800
Message-Id: <cover.1332752084.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
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
X-List-Received-Date: Mon, 26 Mar 2012 10:49:02 -0000

These patches are to fix bugs for Hob.

The following changes since commit fb3e59c88eda5ee3a53ad04aafaa7b749ecc1cc2:

  core-image-minimal-mtdutils.bb: Simple DESCRIPTION grammar fix. (2012-03-25 12:27:43 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-new
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-new

Liming An (5):
  Hob: add refresh icon as ui request in building log
  Hob: fixed visually differentiate warnings and errors icon in
    building log
  Hob: change the recipe pasing error dialog icon from 'dialog-info' to
    'dialog-error'
  Hob: use hob icon checker to check the gtk icon for make the icon
    constaintly
  HOB: Splited configuration info of building log to a independently
    page from the log page

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   10 +-
 bitbake/lib/bb/ui/crumbs/builder.py          |    2 +-
 bitbake/lib/bb/ui/crumbs/hig.py              |    8 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |  196 ++++++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   46 ++++---
 5 files changed, 236 insertions(+), 26 deletions(-)

-- 
1.7.5.4



