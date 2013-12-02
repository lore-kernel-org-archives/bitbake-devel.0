Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 519EC6DD15
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 18:58:55 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Dec 2013 10:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,812,1378882800"; d="scan'208";a="443340767"
Received: from pmcgurk-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.121.184])
	by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2013 10:58:52 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Dec 2013 18:58:44 +0000
Message-Id: <cover.1386010573.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/3] BitBake UI changes for OE-Core pkgdata improvements
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
X-List-Received-Date: Mon, 02 Dec 2013 18:58:55 -0000

These changes correspond with the ones sent for OE-Core that change how
PKGSIZE and FILES_INFO are written in pkgdata (affecting the Hob and
Toaster UIs) as well as a minor related code cleanup.


The following changes since commit 78ad15b669b9c7cde41f7bd1ab884c1d2e0db91b:

  hob: fix rotating progress icon animation (2013-12-02 17:51:27 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/pkgdata-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/pkgdata-bb

Paul Eggleton (3):
  lib/bb/ui: handle PKGSIZE change to bytes
  hob: name package files list variables appropriately
  hob: fix package property dialog for changes to FILES_INFO

 lib/bb/ui/buildinfohelper.py           |  2 +-
 lib/bb/ui/crumbs/hig/propertydialog.py | 64 +++++++++++++---------------------
 lib/bb/ui/crumbs/hoblistmodel.py       |  7 ++--
 3 files changed, 29 insertions(+), 44 deletions(-)

-- 
1.8.1.2


