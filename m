Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcmjT-0000cC-Tr
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jul 2011 01:02:44 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 01 Jul 2011 15:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,461,1304319600"; d="scan'208";a="22927193"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.137])
	by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2011 15:58:57 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Jul 2011 15:58:49 -0700
Message-Id: <cover.1309560728.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] Hob - BitBake GUI (v2)
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
X-List-Received-Date: Fri, 01 Jul 2011 23:02:44 -0000

Since the first revision the groundwork patches have been merged and I fixed
a couple of issues noticed today. Namely:
1) The wording in the "Build Complete" dialog no longer matched the buttons
2) The recipe writing code now handles images with a base image outside of
the oe-core metadata

To see just these two changes look to the top two patches on:
https://github.com/incandescant/bitbake/commits/hob-work

As noted in the v1 pull request images are built by first using the
buildTargets command to build all of the target dependencies then creating a
recipe file and using the buildFile command to handle the build.
The problem is that if you have a clean build directory, perfectly reasonable
with such a tool, the buildFile command does not handle the native
dependencies added by the image class.

Richard has suggested I modify the GUI to insert a path into BBPATH and then
I can rely on buildTasks. I'm working on this now but didn't want to send a
half baked patch.

Cheers,
Joshua

The following changes since commit a8246ae5400c23df0d3ee29c36f4d9f257d1e6d1:

  bitbake: add -R option for loading configuration files after bitbake.conf (2011-07-01 17:03:03 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (1):
  hob: re-designed interaction and implementation

 lib/bb/ui/crumbs/configurator.py    |  278 +++++++++++
 lib/bb/ui/crumbs/hig.py             |   61 +++
 lib/bb/ui/crumbs/hobeventhandler.py |  218 +++++++--
 lib/bb/ui/crumbs/hobprefs.py        |  293 +++++++++++
 lib/bb/ui/crumbs/layereditor.py     |  136 +++++
 lib/bb/ui/crumbs/runningbuild.py    |   12 +-
 lib/bb/ui/crumbs/tasklistmodel.py   |  326 ++++++++++---
 lib/bb/ui/hob.py                    |  924 +++++++++++++++++++++++-----------
 8 files changed, 1824 insertions(+), 424 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/configurator.py
 create mode 100644 lib/bb/ui/crumbs/hig.py
 create mode 100644 lib/bb/ui/crumbs/hobprefs.py
 create mode 100644 lib/bb/ui/crumbs/layereditor.py

-- 
1.7.5.4



