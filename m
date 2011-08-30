Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QySo9-00068A-EO
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Aug 2011 20:13:09 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Aug 2011 11:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,303,1312182000"; d="scan'208";a="43987472"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.52])
	by azsmga001.ch.intel.com with ESMTP; 30 Aug 2011 11:08:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2011 11:08:00 -0700
Message-Id: <cover.1314727299.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6] Bug fixes and optimisations for hob
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
X-List-Received-Date: Tue, 30 Aug 2011 18:13:09 -0000

This series includes two bug fixes and a brace of patches to speed up some
operations on the gtk.ListStore that became apparent as I was reviewing the
code for the bug fixes.

Regards,
Joshua

The following changes since commit 6555a77c199f41bf35460138764e03e30c56d29f:

  data_smart.py: make use of expand cache in getVar() (2011-08-29 14:13:25 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (6):
  ui/crumbs/tasklistmodel: don't add same item to binb column more than
    once
  ui/crumbs/tasklistmodel: prevent packages depending on each other
  ui/crumbs/tasklistmodel: optimise find_path_for_item()
  ui/crumbs/tasklistmodel: remove unnecessary check
  ui/crumbs/tasklistmodel: loop optimisation in include_item()
  ui/crumbs/tasklistmodel: don't add empty entries to COL_BINB

 lib/bb/ui/crumbs/tasklistmodel.py |   68 +++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 37 deletions(-)

-- 
1.7.6



