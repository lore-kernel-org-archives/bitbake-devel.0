Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qgkt9-0003ca-B4
	for bitbake-devel@lists.openembedded.org;
	Tue, 12 Jul 2011 23:53:07 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 12 Jul 2011 14:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,522,1304319600"; d="scan'208";a="27131394"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2011 14:49:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Jul 2011 14:48:57 -0700
Message-Id: <cover.1310507186.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/3] Bug fixes for the hob GUI
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
X-List-Received-Date: Tue, 12 Jul 2011 21:53:07 -0000

The attached series contains three patches which fix Yocto bugs #1218 and
#1219. More detail in the commit headers.

The following changes since commit 521909d1350a415d19516aa1710041e30950c7cc:

  bitbake cooker/ui: handle cmd line parsing result by individual UI. (2011-07-08 17:38:06 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (3):
  ui/crumbs/tasklistmodel: update brought in by column when possible
  ui/crumbs/tasklistmodel: fix automatic removal of orphaned items
  cooker: only return *Found events if something was actually found

 lib/bb/cooker.py                  |   12 ++++++---
 lib/bb/ui/crumbs/tasklistmodel.py |   48 ++++++++++++++++++++++--------------
 2 files changed, 37 insertions(+), 23 deletions(-)

-- 
1.7.6



