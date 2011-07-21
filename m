Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjy4S-00053G-G6
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 20:34:04 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 11:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28648886"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 11:29:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 11:34:17 -0700
Message-Id: <cover.1311273097.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6] Hob fixes
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
X-List-Received-Date: Thu, 21 Jul 2011 18:34:04 -0000

This includes several fixes which are low impact for the core BitBake
functionality (only touch files in lib/ui/crumbs and the hob entry point) but
which improve the usefulness of the GUI whilst the reparseFiles/stashed copy
of the environment issue is being worked through.

The following changes since commit 09a9146262d58dfe4a2ea4270026b90ae33f6c91:

  parse/ConfHandler: Fix multiline variable corruption (2011-07-21 11:08:19 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (6):
  ui/crumbs/hobprefs: add missing import
  ui/crumbs/tasklistmodel: fix saving recipes
  ui/hob: add more guidance to the stop dialog
  ui/crumbs/configurator: write new lines after new entries
  ui/hob: don't crash if PARALLEL_MAKE doesn't include a space
  ui/crumbs/tasklistmodel: ignore tasks and images when marking
    dependencies

 lib/bb/ui/crumbs/configurator.py  |    2 +-
 lib/bb/ui/crumbs/hobprefs.py      |    1 +
 lib/bb/ui/crumbs/tasklistmodel.py |   24 ++++++++++++++++++------
 lib/bb/ui/hob.py                  |   11 +++++++++--
 4 files changed, 29 insertions(+), 9 deletions(-)

-- 
1.7.6



