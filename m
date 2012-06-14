Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1Sf9Ae-0004CB-U2
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 14:29:05 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Jun 2012 05:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="153116376"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga001.jf.intel.com with ESMTP; 14 Jun 2012 05:18:26 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Jun 2012 20:21:38 +0800
Message-Id: <cover.1339676383.git.limingx.l.an@intel.com>
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
X-List-Received-Date: Thu, 14 Jun 2012 12:29:05 -0000

The following changes since commit 7f017cab0b3e4d5a4fc356eccd8eb8429b0531d0:

  connman: bump PR and add some comments (2012-06-13 13:11:23 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (2):
  Hob: fixed an issue about no 'set_page' function in hob failed page
    show
  Hob: fixed issue about 'select a base image' combo not sensitive

 bitbake/lib/bb/ui/crumbs/builder.py   |    2 ++
 bitbake/lib/bb/ui/crumbs/hobwidget.py |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

-- 
1.7.5.4



