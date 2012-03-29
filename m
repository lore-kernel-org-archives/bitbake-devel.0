Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SDNy8-0002EZ-F2
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 00:37:24 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="123312763"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.148])
	by orsmga001.jf.intel.com with ESMTP; 29 Mar 2012 15:28:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 15:28:07 -0700
Message-Id: <cover.1333060005.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/3] A few more Hob tweaks
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
X-List-Received-Date: Thu, 29 Mar 2012 22:37:24 -0000

Here are a few more tweaks for Hob based on design team feedback.

Please review for inclusion.

Thanks,
Joshua

The following changes since commit 8fed4fdf4bbbc9ef036ff96755c0bfe15c3a9dd0:

  knotty: Add back getTasks() call to ensure we don't repeat messges (2012-03-29 21:38:25 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (3):
  Hob: tweak font sizes and layout
  lib/bb/ui/crumbs/hobpages: change title from HOB to Hob
  lib/bb/ui/crumbs/hoblistmodel: fix sorting of RecipeListModel

 lib/bb/ui/crumbs/hoblistmodel.py           |    8 +----
 lib/bb/ui/crumbs/hobpages.py               |    8 +++---
 lib/bb/ui/crumbs/hobwidget.py              |    8 +++---
 lib/bb/ui/crumbs/imageconfigurationpage.py |   36 ++++++++++++++--------------
 4 files changed, 28 insertions(+), 32 deletions(-)

-- 
1.7.7.6



