Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJhM0-0006Av-IT
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 10:32:08 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 16 Apr 2012 01:22:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="154059306"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2012 01:22:42 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 16:53:21 +0800
Message-Id: <cover.1334565351.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Hob UI fixes
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
X-List-Received-Date: Mon, 16 Apr 2012 08:32:08 -0000

These are two UI fixes submitted by Liming.

One is to fix the overlay-scrollbar with the multiple overlaped scrollbar in
'Recipe View' notebook or 'Package View' notebook.

The other is to fix the binb dialog, without the patch, we could have a lot
of binb dialogs and should close them in order on Ubuntu 11.10. But on Ubuntu
10.04, no that issue.

Please review and check in.

The following changes since commit 2ddf7d3e8326e8cb07101ddb2d6e5dc6866371e2:

  gcc-configure-common.inc: Stop gcc looking at build system paths (2012-04-15 18:09:57 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob_0416
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob_0416

Liming An (2):
  Hob: fixed the issue that the notebook overlay-scrollbar is
    overlapped
  Hob: add the parent window to 'binb' popup window for managing it

 bitbake/lib/bb/ui/crumbs/builder.py           |    2 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py         |    1 -
 bitbake/lib/bb/ui/crumbs/persistenttooltip.py |    6 +++++-
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.7.6



