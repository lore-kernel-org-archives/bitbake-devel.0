Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SA9La-0004j2-Mu
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 01:24:14 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 17:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119778612"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.207])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 17:15:20 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 17:15:13 -0700
Message-Id: <cover.1332288516.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/5] Hob GUI tweaks
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
X-List-Received-Date: Wed, 21 Mar 2012 00:24:14 -0000

All,

Here are some tweaks to the Hob GUI.

Firstly I include a tweaked version of my recent LayerSelectionDialog patch, this
includes Dongxiao's suggestion to use a prelight on the clickable pixbuf in the
TreeView. Sadly on Ubuntu this isn't hugely noticable as the remove icon is
largely whitespace.
We should be able to replace the stock icon with a custom one soon.

The second patch adds a clear button to the search entry in HobNoteBook, per a
suggestion I made whilst reviewing that code.

The remaining three patches are for the PersistentTooltip widget:
1) Tweak borders so that the button is aligned with the tooltip edge but the
label remains inside padding.
2) Fix colours on darker Gtk+ themes, such as those used in Ubuntu Unity.
3) Fix whitespace to match the rest of BitBake (I had accidentally used tabs
rather than 4 spaces per indent).

Cheers,
Joshua

The following changes since commit b7b7c768761d205bc5a60922ff709c9c184d4158:

  utils: Add split_version function for splitting a version into its components (2012-03-20 14:37:16 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob
  git://git.yoctoproject.org/poky-contrib josh/hob
  http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob

Joshua Lock (5):
  ui/crumbs/hig: make the layer selection dialogue more closely match
    design
  ui/crumbs/hobwidget: add clear icon to search entries in HobNotebook
  ui/crumbs/persistenttooltip: tweak borders
  ui/crumbs/persistenttooltip: fix colours on darker themes
  ui/crumbs/persistenttooltip: fix whitespace

 lib/bb/ui/crumbs/hig.py               |   97 ++++++++++---
 lib/bb/ui/crumbs/hobwidget.py         |   19 ++-
 lib/bb/ui/crumbs/persistenttooltip.py |  244 ++++++++++++++++++---------------
 3 files changed, 221 insertions(+), 139 deletions(-)

-- 
1.7.7.6



