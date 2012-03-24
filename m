Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SBEtq-0001JU-BC
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 01:32:06 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 23 Mar 2012 17:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121096254"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.82])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 17:23:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 17:22:58 -0700
Message-Id: <cover.1332545580.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/9] Hob visual refinements to more closely match design
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
X-List-Received-Date: Sat, 24 Mar 2012 00:32:06 -0000

All,

This series of patches is developed to make the Hob GUI look more like the proposed
visual design.

The series includes two significant changes:

* a set of changes to change all dialogue buttons to the primary/secondary action
styling (big orange buttons that draw users in for the primary action help the
user feel guided through the GUI, blue subtle link-like buttons for secondary
actions).

* using the PersistentTooltip widget for the 'Brought in by' dialogues to more
closely match the design.

These can both be seen in the screenshot here:
https://wiki.yoctoproject.org/wiki/File:Hob2-visual-preview-230312.png

Cheers,

Joshua

The following changes since commit 0348ef08db9ac425d83126d2e6eb465adc28b110:

  Hob: Change the descriptions for view_recipe_button and view_package_button (2012-03-23 16:09:35 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (9):
  lib/bb/ui/crumbs/hig: sort layers in Layer Selection dialogue
  lib/bb/ui/crumbs/hobwidget: HobAltButton different visual when
    insensitive
  lib/bb/ui/crumbs/recipeselectionpage: add 'Build image' button per
    design
  lib/bb/ui/crumbs/builddetailspage: fix label on 'Back' button
  lib/bb/ui/crumbs/hobwidget: convert button styling logic to static
    methods
  lib/bb/ui/crumbs/persistenttooltip: layout tweaks
  lib/bb/ui/crumbs/persistenttooltip: ensure a reasonable minimum size
  lib/bb/ui/crumbs: use a PersistentTooltip for the Brought in by
    information
  lib/bb/ui/crumbs: apply primary/secondary dialogue button styling

 lib/bb/ui/crumbs/builddetailspage.py    |    2 +-
 lib/bb/ui/crumbs/builder.py             |  118 +++++++++++++++++++------------
 lib/bb/ui/crumbs/hig.py                 |   65 +++++++----------
 lib/bb/ui/crumbs/hobwidget.py           |   58 ++++++++++++---
 lib/bb/ui/crumbs/persistenttooltip.py   |   27 ++++---
 lib/bb/ui/crumbs/recipeselectionpage.py |   18 ++++--
 6 files changed, 177 insertions(+), 111 deletions(-)

-- 
1.7.7.6



