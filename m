Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEine-0005fv-75
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 17:04:06 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 02 Apr 2012 07:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="127813833"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 02 Apr 2012 07:54:52 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 23:22:31 +0800
Message-Id: <cover.1333379931.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/4] Continue Hob fixes
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
X-List-Received-Date: Mon, 02 Apr 2012 15:04:06 -0000

The patches is to continue Shane Wang's previous submission to fix Hobs.
They include:
 - Replace an icon
 - Add logs and allow users to retrieve the logs after successful build
 - Misc fixes when testing

The following changes since commit f4b102cdf2cd021a0b5acacb034dd568a8e73817:

  Hob: a minor fix on pmake (2012-04-02 16:25:56 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob-fixes-1
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-1

Shane Wang (4):
  Hob: add the "info" indication icon for "information" in the dialogs.
  Hob: log for Hob and allow users to show logs after successful build
  Hob: remove grab_default() for deploy button
  Hob: reset issue indication and build status before build starts on
    build details screen

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 +
 bitbake/lib/bb/ui/crumbs/builder.py          |   38 +++++++++++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    3 +
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |    3 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   15 ++++++-
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   53 ++++++++++++++++++++++++++
 bitbake/lib/bb/ui/icons/indicators/info.png  |  Bin 0 -> 3311 bytes
 7 files changed, 106 insertions(+), 9 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/info.png

-- 
1.7.6



