Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1STus1-0002Pw-Q6
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 May 2012 14:59:25 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 May 2012 05:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="143675149"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga002.jf.intel.com with ESMTP; 14 May 2012 05:49:25 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 May 2012 20:51:45 +0800
Message-Id: <cover.1336999687.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/3] Hob: bug-fixes
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
X-List-Received-Date: Mon, 14 May 2012 12:59:26 -0000

The following changes since commit 12b4543ac9f54c0db0ee4a7ee546a71946a051f8:

  classes/rootfs_*: fix splitting package dependency strings (2012-05-13 20:09:56 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (3):
  Hob: apply a line length to consistantly across 'base image'
    descriptions
  Hob: add '--select a machine--' and '--select a base image--' to GUI
  Hob:add function about clicked a row to load image file for 'my
    images' page

 bitbake/lib/bb/ui/crumbs/builder.py                |    6 ++--
 bitbake/lib/bb/ui/crumbs/hig.py                    |   18 ++++++++-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |    6 ++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   37 +++++++++++++++----
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
 5 files changed, 52 insertions(+), 17 deletions(-)

-- 
1.7.5.4



