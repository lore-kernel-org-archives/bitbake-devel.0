Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDEb6-0007zx-UR
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:37:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Mar 2012 05:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="126525593"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Mar 2012 05:27:56 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:54:43 +0800
Message-Id: <cover.1333025490.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/8] Hob: bug fixes
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
X-List-Received-Date: Thu, 29 Mar 2012 12:37:01 -0000

This patchset includes the several Hob fixes:
  - fix the icons to be consistent on the whole GUI
  - fix the color style of the HobTabBar per visual design
  - add more checks before being used to avoid bitbake exception
  - fix the button label, etc.

The following changes since commit 0057d7fde8315694307637c4d23fd414a4a200f9:

  lib/bb/ui/crumbs/hig: fix layers_changed test (2012-03-29 10:44:54 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob

Liming An (2):
  Hob: fixed the 'error' icon source picture and adjusted corresponding
    showed icon size
  Hob: in build details page, change error icon to denied icon

Shane Wang (6):
  Hob: clear the building state after a successful build, as a failed
    build does
  Hob: Change icon to error because parsing error is an error
  Hob: Change "Just bake" to "Build image" as required
  Hob: make ORANGE to be the same as the color on the dialog
  runqueue.py: check results[0] in keys of build_pids before being used
    to avoid exceptions
  Hob: some color style changes to make HobTabBar more close to visual
    design

 bitbake/lib/bb/runqueue.py                         |   20 +++++++++------
 bitbake/lib/bb/ui/crumbs/builder.py                |    3 +-
 bitbake/lib/bb/ui/crumbs/hobcolor.py               |    6 +---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    3 ++
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |   25 ++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    6 ++--
 bitbake/lib/bb/ui/crumbs/runningbuild.py           |    2 +-
 7 files changed, 43 insertions(+), 22 deletions(-)

-- 
1.7.6



