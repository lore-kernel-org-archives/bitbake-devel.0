Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D48B360886
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  6 Aug 2013 11:13:27 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 06 Aug 2013 04:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,825,1367996400"; d="scan'208";a="358312277"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.203])
	by orsmga001.jf.intel.com with ESMTP; 06 Aug 2013 04:13:13 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Aug 2013 12:13:09 +0100
Message-Id: <cover.1375787400.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 00/21] CONSOLIDATED PULL: bitbake changes for master (cover letter only)
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 06 Aug 2013 11:13:28 -0000

These have been tested locally and reviewed by me.

The following changes (against poky, but apply cleanly to bitbake
master with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake

Cristiana Voicu (18):
  hob/advancedsettings: change toolchain labels to sdk labels
  hob/packageslist: change image size label to estimated image size
  hob: labelling changes in Hob
  hob: create save image dialog used to save a template
  hob/bitbake: create a template (a .bb file) from hob through bitbake
  hob/bitbake: save the description of a custom image
  hob: make changes in order to permit from UI to edit an image after
    saving it
  hob & bitbake: append a value to a variable from hob throught bitbake
  hob: change the name and description for the saveimagedialog
  hob: the saved image should be editable
  hob/bitbake: when an image is saved, it should require an image from
    layers
  hob: changes to image combo box
  hob: retrieve file name of an image
  hob: implement the "retrieve image dialog" + changes to image combo
    box
  cooker: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
  hob: set focus on entry name when the name is not correct
  hob/imagedetailspage: add tooltip for save image recipe button
  hob/imageconfigurationpage: changes to image combobox

Ross Burton (3):
  depexp: make parse() a member function
  depexp: insert data instead of append/set, for speed
  depexp: fix typo in variable name

 bitbake/lib/bb/command.py                          |  14 +-
 bitbake/lib/bb/cooker.py                           |  71 ++++++++--
 bitbake/lib/bb/data.py                             |   4 +
 bitbake/lib/bb/ui/crumbs/builder.py                |  15 ++
 .../lib/bb/ui/crumbs/hig/advancedsettingsdialog.py |  21 +--
 .../lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |  49 +++++++
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py    | 151 +++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |  25 +++-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |  40 ++++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |  76 ++++++++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  44 +++++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   2 +-
 bitbake/lib/bb/ui/depexp.py                        |  28 ++--
 13 files changed, 461 insertions(+), 79 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py

-- 
1.8.1.2


