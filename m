Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S9zzV-0000bn-Gt
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:24:49 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 07:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119555056"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 07:15:55 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 22:40:45 +0800
Message-Id: <cover.1332254194.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 00/11] [V4]Hob Notebook Implementation and Others
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
X-List-Received-Date: Tue, 20 Mar 2012 14:24:49 -0000

This patchset is
 - to implement Hob self-defined notebook, and use it in the build details page.
 - to clean up the code per the comments from the community.
   (In order to make it readable, we did them in separate patches)

Compared with V3 version, this version temporarily removed the patches for
 - to improve the build log with the animation of the refresh icon.
 - to add proxy support in the Settings dialog.

Because the updated patches are not ready so far per the comments from the community.

The following changes since commit fd3514f35adc938c2c405aae0e283a9df1395c9b:

  blktrace: update to version 1.0.5 (2012-03-19 20:28:48 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob2-v0.70
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.70

Liming An (6):
  Hob: remove the invalid code in hobwidget.py
  Hob: Fixed the hobwidget code and make it like a pythonista
  Hob: add auto adjust background area function for long issue text
  Hob: change HobNoteBook tab edge color from green to gray
  Hob: fix static variable "self.search" to parameter "search" in
    signal callback function
  Hob: fixed the tabbar search entry retaining focus when user has
    clicked off it issue

Shane Wang (5):
  Hob: implement a self-defined notebook visual component for Hob
  Hob: use HobNotebook to implement a notebook in build details page
  Hob: show indicators on the tabs of the Hob notebook
  Hob: change the code style to enumerate a list in a for-loop
  Hob: fix '!= None' and '== None' in the code

 bitbake/lib/bb/ui/crumbs/builddetailspage.py     |   40 ++-
 bitbake/lib/bb/ui/crumbs/builder.py              |    5 +
 bitbake/lib/bb/ui/crumbs/hobcolor.py             |    3 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py      |    4 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    2 +-
 bitbake/lib/bb/ui/crumbs/hobpages.py             |    4 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |  528 ++++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   12 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   27 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   29 +-
 bitbake/lib/bb/ui/crumbs/runningbuild.py         |   69 +++
 11 files changed, 571 insertions(+), 152 deletions(-)

-- 
1.7.6



