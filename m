Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SJizx-00021L-OB
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Apr 2012 12:17:29 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 16 Apr 2012 03:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="142211195"
Received: from hp.sh.intel.com ([10.239.47.1])
	by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2012 03:08:03 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 18:09:43 +0800
Message-Id: <1334570983-12666-1-git-send-email-limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] Hob: bug-fixes
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
X-List-Received-Date: Mon, 16 Apr 2012 10:17:30 -0000

The following changes since commit 2ddf7d3e8326e8cb07101ddb2d6e5dc6866371e2:

  gcc-configure-common.inc: Stop gcc looking at build system paths (2012-04-15 18:09:57 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-another
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-another

Liming An (1):
  Hob: fixed a little view issue about package selection page

 bitbake/lib/bb/ui/crumbs/hobwidget.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

-- 
1.7.5.4



