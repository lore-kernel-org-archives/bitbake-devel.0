Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmip-0003i5-Om
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353969"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:51 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:34 -0700
Message-Id: <cover.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 00/10] Latest round of hob UI improvements
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:16 -0000

Highlights are using buildTargets rather than buildFiles to build the custom
image and enabling building an image without a 'Base image' set.
Plus a slew of more minor fixes.

The following changes since commit d11f9dd33cdcc97a4a937e8bf7e97558d813cadd:

  cooker: only append files once (2011-07-26 13:45:31 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Jessica Zhang (1):
  ui/crumbs/tasklistmodel: fix loading a saved recipe

Joshua Lock (9):
  ui/hob: replace the ugly static command map
  ui/crumbs/hobeventhandler: reparse files before running other
    commands
  ui/hob: switch from buildFile to buildTargets for custom image builds
  ui/hob: don't offer to show built output if build fails
  ui/hob: change wording in build complete dialog
  ui/hob: Force the 'Base image combo' to be drawn correctly
  ui/hob: enable building an image with minimal contents
  ui/crumbs/tasklistmodel: handle items added in by base image being
    removed
  ui/crumbs/tasklistmodel: don't iterate whole model in
    find_alt_dependency()

 lib/bb/ui/crumbs/configurator.py    |   18 +++++
 lib/bb/ui/crumbs/hobeventhandler.py |  127 +++++++++++++++++++++++------------
 lib/bb/ui/crumbs/tasklistmodel.py   |   51 ++++++++++----
 lib/bb/ui/hob.py                    |   63 +++++++++++------
 4 files changed, 179 insertions(+), 80 deletions(-)

-- 
1.7.6



