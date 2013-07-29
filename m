Return-Path: <cristiana.voicu@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B7BAA6B446
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 12:56:56 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jul 2013 05:56:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,769,1367996400"; d="scan'208";a="372875938"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jul 2013 05:56:55 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 15:59:14 +0300
Message-Id: <1375102770-14079-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH_V3 00/16] bitbake+hob: templates enhancement
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 12:56:57 -0000

This set implements the templates functionality in Hob.
There are two new files, with two different dialogs.
The changes are in bitbake and in Hob.

Cristiana Voicu (16):
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
  bitbake: save packages in IMAGE_INSTALL instead of PACKAGE_INSTALL
  hob: set focus on entry name when the name is not correct
  hob/imagedetailspage: add tooltip for save image recipe button
  hob/imageconfigurationpage: changes to image combobox

 bitbake/lib/bb/command.py                          |   14 +-
 bitbake/lib/bb/cooker.py                           |   71 +++++++--
 bitbake/lib/bb/data.py                             |    4 +
 bitbake/lib/bb/ui/crumbs/builder.py                |   15 ++
 .../lib/bb/ui/crumbs/hig/retrieveimagedialog.py    |   49 +++++++
 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py    |  151 ++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   25 +++-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   40 ++++--
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   76 +++++++---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   44 +++++-
 10 files changed, 438 insertions(+), 51 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/retrieveimagedialog.py
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/saveimagedialog.py

-- 
1.7.9.5


