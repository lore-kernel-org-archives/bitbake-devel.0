Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SZhhe-0003o1-Cy
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 14:08:38 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 30 May 2012 04:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="146186409"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga001.jf.intel.com with ESMTP; 30 May 2012 04:58:18 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 20:01:06 +0800
Message-Id: <cover.1338379209.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/2] Hob: bug-fixes
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
X-List-Received-Date: Wed, 30 May 2012 12:08:38 -0000

The following changes since commit 0299499770e33e0214146132799f8779e81e581d:

  ccache: Separate out into its own class (2012-05-30 12:04:49 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (2):
  Hob: Fixed a compatible issue for indicator icon view
  Hob: add the 'build new' be as the primary action for 'Image detail'
    page

 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   51 ++++----------------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   19 ++++------
 2 files changed, 16 insertions(+), 54 deletions(-)

-- 
1.7.5.4



