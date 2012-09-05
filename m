Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1T9Deh-0003mY-6h
	for bitbake-devel@lists.openembedded.org;
	Wed, 05 Sep 2012 13:20:23 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 05 Sep 2012 04:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,372,1344236400"; d="scan'208";a="197161294"
Received: from hp.sh.intel.com ([10.239.47.150])
	by orsmga002.jf.intel.com with ESMTP; 05 Sep 2012 04:07:58 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Sep 2012 19:13:42 +0800
Message-Id: <cover.1346842933.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] hob:bug-fix
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
X-List-Received-Date: Wed, 05 Sep 2012 11:20:23 -0000

The following changes since commit 99c85ba93075a1aff789cafabbacf42e6a93bd32:

  build-appliance-image: Update to latest poky master (2012-09-04 18:04:40 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (1):
  Hob: change view of 'recipes' and 'packages' tables as ui design

 bitbake/lib/bb/ui/crumbs/hoblistmodel.py         |    9 ++++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |    7 +++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   48 +++++----------------
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   37 +++++++----------
 4 files changed, 41 insertions(+), 60 deletions(-)

-- 
1.7.5.4



