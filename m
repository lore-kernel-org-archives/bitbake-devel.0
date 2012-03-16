Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S8YYW-0006HB-2N
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 15:55:00 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 16 Mar 2012 07:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="119800166"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 16 Mar 2012 07:46:10 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 23:10:09 +0800
Message-Id: <cover.1331910234.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 00/12] [V3]Hob Notebook Implementation and Others
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
X-List-Received-Date: Fri, 16 Mar 2012 14:55:00 -0000

This patchset is
 - to implement Hob self-defined notebook, and use it in the build details page.
 - to clean up the code per the comments from the community.
   (In order to make it readable, we did them in separate patches)
 - to improve the build log with the animation of the refresh icon.
 - to add proxy support in the Settings dialog.

The following changes since commit 87ef82dead665ea8805ccbab8ef871dc20008701:

  bitbake/fetch: Fix uri_replace (2012-03-15 22:56:16 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob2-v0.69
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.69

Liming An (6):
  Hob: remove the invalid code in hobwidget.py
  Hob: change the range dance in hobwidget make it like a pythonista
  Hob: fix static variable "self.search" to parameter "search" in
    signal callback function
  Hob: add auto adjust background area function for long issue text
  Hob: change HobNoteBook tab edge color from green to gray
  Hob: per UI design add refresh icon for building log

Shane Wang (6):
  Hob: implement a self-defined notebook visual component for Hob
  Hob: use HobNotebook to implement a notebook in build details page
  Hob: show indicators on the tabs of the Hob notebook
  Hob: change the code style to enumerate a list in a for-loop
  Hob: fix '!= None' and '== None' in the code
  Hob: allow users to setup the proxies

 bitbake/lib/bb/ui/crumbs/builddetailspage.py     |   40 +-
 bitbake/lib/bb/ui/crumbs/builder.py              |   41 ++
 bitbake/lib/bb/ui/crumbs/hig.py                  |   82 +++-
 bitbake/lib/bb/ui/crumbs/hobcolor.py             |    3 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py      |    4 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    2 +-
 bitbake/lib/bb/ui/crumbs/hobpages.py             |    4 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |  720 +++++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   12 +-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   27 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   29 +-
 bitbake/lib/bb/ui/crumbs/runningbuild.py         |   87 +++-
 12 files changed, 884 insertions(+), 167 deletions(-)

-- 
1.7.6



