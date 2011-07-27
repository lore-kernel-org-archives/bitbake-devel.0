Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlvJd-0007hu-2u
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:01:49 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="34904867"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by fmsmga001.fm.intel.com with ESMTP; 26 Jul 2011 20:57:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 20:57:23 -0700
Message-Id: <cover.1311738866.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/4] Hob bug fixes
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
X-List-Received-Date: Wed, 27 Jul 2011 04:01:49 -0000

All,

Some more bug fixes for the hob UI hoping to make it in before we freeze Poky
for Yocto 1.1M3.

Thanks,
Joshua

The following changes since commit 2650be190afc05f9472aca8b11af99205a342838:

  ui/crumbs/tasklistmodel: fix loading a saved recipe (2011-07-26 09:42:28 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Jessica Zhang (1):
  ui/crumbs/hobprefs: trigger reparse when package format changed

Joshua Lock (3):
  ui/crumbs/tasklistmodel: work around overly aggressive package
    removal
  hob: fix loading customised image recipe
  cooker: populate rdepends-pkg in generatePkgDepTreeData

 lib/bb/cooker.py                  |    3 +++
 lib/bb/ui/crumbs/hobprefs.py      |    1 +
 lib/bb/ui/crumbs/tasklistmodel.py |   27 +++++++++++++++++++++++----
 lib/bb/ui/hob.py                  |    6 ++++++
 4 files changed, 33 insertions(+), 4 deletions(-)

-- 
1.7.6



