Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RabEJ-00045I-O5
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 23:53:49 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 13 Dec 2011 14:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="86232573"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.215])
	by orsmga001.jf.intel.com with ESMTP; 13 Dec 2011 14:45:43 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2011 14:45:40 -0800
Message-Id: <cover.1323815814.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.4
Subject: [PATCH 0/2] Hob v1 related fixes
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
X-List-Received-Date: Tue, 13 Dec 2011 22:53:49 -0000

This series works around a couple of issues which I'd like to address for the
Yocto Edison 1.1.1 release.

Regards,
Joshua

The following changes since commit 71b53a3f0766ca464560a1f6a449f9424fbdf7ae:

  siggen.py: If both sigs have a variable in it's whitelist then don't say it's changed (2011-12-05 16:17:38 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (2):
  ui/crumbs/runningbuild: handle InvalidTask events
  ui/crumbs/hobprefs: trigger a reparse after changing IMAGE_FSTYPES

 lib/bb/ui/crumbs/hobprefs.py     |    1 +
 lib/bb/ui/crumbs/runningbuild.py |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

-- 
1.7.7.4



