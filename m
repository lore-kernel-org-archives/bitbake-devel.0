Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SXs19-0002nO-G7
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 May 2012 12:45:11 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 May 2012 03:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="157178224"
Received: from hp.sh.intel.com ([10.239.47.6])
	by fmsmga001.fm.intel.com with ESMTP; 25 May 2012 03:34:57 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 May 2012 18:37:35 +0800
Message-Id: <cover.1337942129.git.limingx.l.an@intel.com>
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
X-List-Received-Date: Fri, 25 May 2012 10:45:11 -0000

The following changes since commit 17f3435f68932056c44f4f8a2ba7838225eac396:

  Hob:fixed the issue of primary button is not an 'orange hob button' (2012-05-25 18:33:34 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (1):
  Hob: Fixed a compatible issue for indicator icon view

 bitbake/lib/bb/ui/crumbs/hobwidget.py |   51 +++++---------------------------
 1 files changed, 8 insertions(+), 43 deletions(-)

-- 
1.7.5.4



