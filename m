Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 75EC36E26A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:26 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359872"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:23 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:06 +0000
Message-Id: <cover.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 00/11] Toaster improvements (BitBake part)
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:26 -0000

Note: this should be merged into BitBake at the same time that the
corresponding changes to toaster.bbclass are merged in OE-Core.


The following changes since commit 8f453bb11d72afc90a986ac604b3477d97eaf9a8:

  data: Ensure we add the contains keys in a particular order (2013-12-09 10:25:41 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/toaster-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/toaster-bb

Alexandru DAMIAN (11):
  toaster: Analysis API variablehistory update
  toaster: remove Author field in SimpleUI
  toaster: move layer information reading code
  toaster: update build stats reading
  toaster: change package storage model
  toasterui: fix version numbers for no PE specified
  toasterui: do not link non-image targets
  toaster: update to Django 1.5
  toaster: migrate orm models to South
  toaster: add pagination to the Simple UI
  toaster: Add more information for tasks in Simple UI

 bin/toaster                                        |  20 +-
 lib/bb/ui/buildinfohelper.py                       | 319 ++++++----------
 lib/bb/ui/toasterui.py                             |   9 +-
 lib/toaster/bldviewer/api.py                       |   1 +
 lib/toaster/bldviewer/templates/base.html          |   4 +-
 lib/toaster/bldviewer/templates/basebuildpage.html |   8 +-
 lib/toaster/bldviewer/templates/basetable.html     |  22 +-
 lib/toaster/bldviewer/templates/bfile.html         |   6 +-
 lib/toaster/bldviewer/templates/bpackage.html      |  12 +-
 lib/toaster/bldviewer/templates/build.html         |   6 +-
 lib/toaster/bldviewer/templates/configuration.html |   2 +-
 lib/toaster/bldviewer/templates/layer.html         |   4 +-
 lib/toaster/bldviewer/templates/package.html       |   8 +-
 lib/toaster/bldviewer/templates/recipe.html        |   3 +-
 lib/toaster/bldviewer/templates/task.html          |  18 +-
 lib/toaster/bldviewer/urls.py                      |   4 +-
 lib/toaster/bldviewer/views.py                     |  70 ++--
 lib/toaster/orm/migrations/0001_initial.py         | 400 +++++++++++++++++++++
 lib/toaster/orm/migrations/__init__.py             |   0
 lib/toaster/orm/models.py                          |  51 +--
 lib/toaster/toastermain/settings.py                |   1 +
 lib/toaster/toastermain/urls.py                    |   4 +-
 22 files changed, 659 insertions(+), 313 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0001_initial.py
 create mode 100644 lib/toaster/orm/migrations/__init__.py

-- 
1.8.1.2


