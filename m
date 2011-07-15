Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qhovz-00046x-V2
	for bitbake-devel@lists.openembedded.org;
	Fri, 15 Jul 2011 22:24:28 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Jul 2011 13:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,210,1309762800"; d="scan'208";a="27770691"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.32])
	by azsmga001.ch.intel.com with ESMTP; 15 Jul 2011 13:20:25 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 15 Jul 2011 13:20:12 -0700
Message-Id: <cover.1310761024.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6] Switch hob from buildFiles to buildTargets
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
X-List-Received-Date: Fri, 15 Jul 2011 20:24:28 -0000

The initial hob merge came with the caveat that it used buildFiles and
therefore a build in a new builddir wouldn't have the required native tools
to actually generate the rootfs.

The key patch in this series switches to using buildTargets by injecting the
directory the generated image recipe is saved to into BBPATH and a BBFILES
pattern then reparsing the files before building.

Further this series includes a bug fix or two and a patch that got lost in
a branch somewhere.

The following changes since commit 5c8eeefc79455f058dda8f04cf4c12dc5418e00f:

  cooker: only return *Found events if something was actually found (2011-07-14 15:12:40 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (6):
  ui/hob: replace the ugly static command map
  ui/crumbs/hobprefs: add missing import
  command|cooker: Add reparseFiles command
  ui/crumbs/hobeventhandler: reparse files before running other
    commands
  ui/crumbs/tasklistmodel: fix saving recipes
  ui/hob: switch from buildFile to buildTargets for custom image builds

 lib/bb/command.py                   |    8 ++
 lib/bb/cooker.py                    |   54 ++++++++-----
 lib/bb/ui/crumbs/configurator.py    |   18 ++++
 lib/bb/ui/crumbs/hobeventhandler.py |  147 +++++++++++++++++++++--------------
 lib/bb/ui/crumbs/hobprefs.py        |    1 +
 lib/bb/ui/crumbs/tasklistmodel.py   |    3 +-
 lib/bb/ui/hob.py                    |   26 +++----
 7 files changed, 161 insertions(+), 96 deletions(-)

-- 
1.7.6



