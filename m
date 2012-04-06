Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SGIZM-0003Lc-Jp
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 01:27:52 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 Apr 2012 16:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129596279"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.176])
	by orsmga002.jf.intel.com with ESMTP; 06 Apr 2012 16:18:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Apr 2012 16:18:32 -0700
Message-Id: <cover.1333754145.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/4] Hob tweaks
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
X-List-Received-Date: Fri, 06 Apr 2012 23:27:52 -0000

A series of minor tweaks based on feedback from design in bug #2182
https://bugzilla.yoctoproject.org/show_bug.cgi?id=2182

Cheers,
Joshua

The following changes since commit d49db15badb77855cef855ee73430fcbc16b6916:

  Hob: a minor fix on pmake (2012-04-05 18:47:37 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (4):
  lib/bb/ui/crumbs: only display one 'Brought in by' item in Hob trees
  lib/bb/ui/crumbs/recipeselectionpage: include 'Group' in 'Included'
    view
  lib/bb/ui/crumbs/[recipe|package]selectionpage: fixed width Included
    col
  selectionpage: show persistent tooltips on click

 lib/bb/ui/crumbs/hobwidget.py            |   15 ++++++++
 lib/bb/ui/crumbs/packageselectionpage.py |   38 +++++++++++++--------
 lib/bb/ui/crumbs/recipeselectionpage.py  |   53 +++++++++++++++++++----------
 3 files changed, 73 insertions(+), 33 deletions(-)

-- 
1.7.7.6



