Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2k7X-00055v-53
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:03:07 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 05:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="116101405"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Feb 2012 05:54:36 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:11:49 +0800
Message-Id: <cover.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Cc: Liming An <limingx.l.an@intel.com>
Subject: [PATCH 00/32] Hob related fixes
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
X-List-Received-Date: Wed, 29 Feb 2012 14:03:07 -0000

The following patches are going to fix the following problems:

* Enable HobNotebook to make notebook more like the design video;
* Improve and enhance the GUI;
* Rebase the patches Josh has sent out before with the title "Hob tweaks";
* Address some tricky issues we found in the bitbake;
* Revise Hob according to the comments on the previous patch set;
* Fix some bugs we found when testing Hob;
* and some temporary walkarounds we have to find a way to solve in Hob or in the bitbake later.

The following changes since commit 927bec5f72230be4f2452d9ef5a747b2c00cb781:

  bitbake.conf: Create a new filter variable BB_HASHCONFIG_WHITELIST (2012-02-27 20:10:41 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob2-v0.68
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob2-v0.68

Dongxiao Xu (10):
  command.py: remove the resolve parameter in generateTargetsTree
  cooker.py: Fix a bug due to variable name
  cooker: fix calculating of depends and rdepends
  Hob(crumbs/hoblistmodel.py): Fix recipe's populate() function
  Hob(crumbs/hoblistmodel.py): Add mapping for rprovides and pkg
  Hob: Add an extra 50M space if zypper is selected
  Hob: add "OK" button to "BinbDialog"
  Hob: Fix pressing "stop" build
  runqueue.py: initialize rqexe at RunQueue's init function
  Hob: Disable the handling of "NoProvider" event

Shane Wang (22):
  Hob: make HobViewTable more general in hob and make the image
    selection dialog and the image details page reuse it.
  Hob: avoid the image selection dialog to walk through all directories
    and its sub-directories, when users click "My images".
  Hob: cleanup those class methods in HobWidget
  Hob: fixed the issue in the brought-in-by dialog.
  Hob: include hddimg and iso into image types.
  Hob: implement a self-defined notebook visual component for Hob
  Hob: use HobNotebook to enable a notebook in build details page
  Hob: image configuration page doesn't need dialogs any more
  Hob: fix a bug in builder.configuration.curr_mach
  Hob: add ignore_all_errors to avoid showing error dialog multiple
    times
  Hob: make the image configuration page not to flash the progress bar
  Hob: enable indicators on the "Included" tab in the recipe selection
    page and the package selection page
  crumbs: Factor common dialogue configuration out
  crumbs/builder: use the name Hob consistently
  crumbs: move towards more standard dialogue spacing
  crumbs: fix button order in several dialogues
  hig: try to avoid setting explicit dialogue sizes
  crumbs/hig: tweak UI and layout of LayerSelectionDialog
  Hob(crumbs/builder.py): remove the code commented out in the
    builder.py
  Hob: fix a bug that the image size is shown incorrectly in the image
    details page.
  Hob: allow users to setup the proxy
  Hob(crumbs/builder.py): adjust the main window's position and ignore
    the case lower than 1024x768.

 bitbake/lib/bb/command.py                          |   14 +-
 bitbake/lib/bb/cooker.py                           |   74 +-
 bitbake/lib/bb/runqueue.py                         |    5 +
 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   40 +-
 bitbake/lib/bb/ui/crumbs/builder.py                |  138 ++-
 bitbake/lib/bb/ui/crumbs/hig.py                    |  672 ++++++++++--
 bitbake/lib/bb/ui/crumbs/hobcolor.py               |    1 +
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   48 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   60 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py              | 1135 ++++++++------------
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   34 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   93 ++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   56 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   55 +-
 bitbake/lib/bb/ui/crumbs/runningbuild.py           |   69 ++
 15 files changed, 1457 insertions(+), 1037 deletions(-)

-- 
1.7.6



