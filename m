Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SwtKo-0005Kq-7s
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 13:12:54 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 02 Aug 2012 04:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129575901"
Received: from hp.sh.intel.com ([10.239.47.150])
	by AZSMGA002.ch.intel.com with ESMTP; 02 Aug 2012 04:01:12 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Aug 2012 19:05:55 +0800
Message-Id: <cover.1343905168.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/2] hob:bug-fixes
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
X-List-Received-Date: Thu, 02 Aug 2012 11:12:54 -0000

The following changes since commit 62d42fe3cfa575cb97b484ccf7b2e9a25cc50770:

  tiny-init: Setup /dev/ptmx in init (2012-08-01 23:11:18 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (2):
  Hob: log for Hob and allow users to show logs after successful build
  Hob: change the Build failure scenario as ui design

 bitbake/lib/bb/ui/crumbs/builddetailspage.py     |   83 +++++++++-------------
 bitbake/lib/bb/ui/crumbs/builder.py              |   52 +++++++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py      |    3 +
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   24 +++++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   27 ++++++-
 bitbake/lib/bb/ui/crumbs/runningbuild.py         |   41 +++++++++++
 6 files changed, 162 insertions(+), 68 deletions(-)

-- 
1.7.5.4



