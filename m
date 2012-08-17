Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1T2Chj-0003af-Vs
	for bitbake-devel@lists.openembedded.org;
	Fri, 17 Aug 2012 04:54:32 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 16 Aug 2012 19:42:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,782,1336374000"; d="scan'208";a="181778966"
Received: from hp.sh.intel.com ([10.239.47.150])
	by orsmga001.jf.intel.com with ESMTP; 16 Aug 2012 19:42:32 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Aug 2012 10:47:40 +0800
Message-Id: <cover.1345171604.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] hob:bug-fixes
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
X-List-Received-Date: Fri, 17 Aug 2012 02:54:32 -0000

The following changes since commit 85c005d71c30bc5de61f9a9eb9818f37183af54b:

  tzdata: Upgrade tzdata to upstream 2012d (2012-08-02 23:21:12 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (1):
  Hob: fixed the build image failure scenario

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   14 ++++++--------
 bitbake/lib/bb/ui/crumbs/builder.py          |    3 ++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |    2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

-- 
1.7.5.4



