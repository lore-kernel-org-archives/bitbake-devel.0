Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QreBf-0004uv-Pq
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 00:57:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="36965234"
Received: from vorpal.jf.intel.com ([10.7.199.53])
	by orsmga002.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2011 15:57:23 -0700
Message-Id: <cover.1313103368.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/8] Various hob related patches
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
X-List-Received-Date: Thu, 11 Aug 2011 22:57:16 -0000

This pull request includes the series I submitted yesterday as well as some
additional bug fixes.

Regards,
Joshua

The following changes since commit 705d14d1e1108e0544c7eab827f1242f0839add9:

  bb/cooker: only emit ConfigFilePathFound for files which were parsed (2011-08-10 13:38:11 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (8):
  bb/ui/crumbs/tasklistmodel: fix some typos and add comments to mark()
  bb/ui/crumbs/tasklistmodel: correctly uniquify dependency list
  bb/ui/crumbs/tasklistmodel: don't include an item in its own depends
  bb/cache: rename confusing variable
  bb/command|cooker: refactor the reparseFiles logic
  bb/ui/crumbs/hobeventhandler: adapt to reset -> reparse change
  bb/ui/crumbs/configurator: introduce writeConfFile method for all
    writes
  lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse

 lib/bb/cache.py                     |    6 ++--
 lib/bb/command.py                   |    7 +++++
 lib/bb/cooker.py                    |    9 ++++--
 lib/bb/ui/crumbs/configurator.py    |   46 ++++++++++++++--------------------
 lib/bb/ui/crumbs/hobeventhandler.py |    1 +
 lib/bb/ui/crumbs/hobprefs.py        |    1 +
 lib/bb/ui/crumbs/tasklistmodel.py   |   28 +++++++++++++++------
 7 files changed, 57 insertions(+), 41 deletions(-)

-- 
1.7.6



