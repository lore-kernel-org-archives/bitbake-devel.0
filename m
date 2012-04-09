Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF1t-0007ok-Rd
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 15:53:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2012 06:43:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="130290211"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 09 Apr 2012 06:43:55 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:09:54 +0800
Message-Id: <cover.1333980504.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 00/21] [Resend] Hob fixes and cleanups
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
X-List-Received-Date: Mon, 09 Apr 2012 13:53:14 -0000

Those patches fix the following:
  - the UI bug to fade out the entry in the "Included" page when it is removed
  - add and correct tooltips reviewed by Scott
  - clean up the code and maximize reusage, for exception handling
  - misc

The following changes since commit 190f6d791d51aaa4cfb9f1cf932bc205ff674fb5:

  runqemu-internal: Add console=tty for qemuppc and NFS (2012-04-06 01:12:47 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-continue

Liming An (4):
  Hob: add fadeout display effection for recipe view include page
  Hob: add fadeout display effection for package view include page
  Hob: Add the tooltips for recipe view page as request
  Hob:Fixed some incorrect values of Build configuration tab

Shane Wang (17):
  Hob: fix version check - Hob can run on pygtk 2.21.0
  Hob: correct indent
  Hob: clean up and unify the steps for new build to call
    initiate_new_build_async()
  Hob: clean up and unify the steps for CONFIG_UPDATE to call
    update_config_async()
  Hob: clean up and unify the steps for RCPPKGINFO_POPULATING to call
    populate_recipe_package_info_async()
  Hob: clean up and unify the steps for PACKAGE_GENERATING and
    FAST_IMAGE_GENERATING to call generate_packages_async() and
    fast_generate_image_async()
  Hob: clean up and unify the steps for IMAGE_GENERATING to call
    generate_image_async()
  Hob: clean up to call clear_busy() in hobeventhandler.py
  Hob: clean up and unify get_parameters() to be get_parameters_sync()
  Hob: clean up request_package_info_async()
  Hob: clean up cancel_build()
  Hob: clean up generate_configuration()
  Hob: clean up and reword stop_parse()
  Hob: tooltip change for "Build image" button
  Hob: add tooltips into image details screen
  Hob: forget selected_recipes and selected_packages after users change
    the machine
  Hob: show those appliable buttons on the image details page only

 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   20 ++-
 bitbake/lib/bb/ui/crumbs/builder.py                |  164 +++++++++++---------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    7 +-
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   35 ++++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |  155 ++++++++++++++++---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   30 +++-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  136 +++++++++++-----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   54 ++++++-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |   58 ++++++-
 bitbake/lib/bb/ui/hob.py                           |    2 +-
 10 files changed, 482 insertions(+), 179 deletions(-)

-- 
1.7.6



