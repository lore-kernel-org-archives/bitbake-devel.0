Return-Path: <valentin.popa@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id B1CD46D73C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Dec 2013 15:52:09 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 03 Dec 2013 07:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,818,1378882800"; d="scan'208";a="437798199"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by fmsmga001.fm.intel.com with ESMTP; 03 Dec 2013 07:52:08 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Dec 2013 17:52:57 +0200
Message-Id: <cover.1386085911.git.valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [PATCH 0/1] Hob: check if warnings are related to package build
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
X-List-Received-Date: Tue, 03 Dec 2013 15:52:10 -0000


The following changes since commit a6450a951fd52d1330c577139dd492f0c8abb1f8:

  ref-manual: Added the multilib* class. (2013-12-03 12:53:40 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib vpopa/YOCTO_5621
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=vpopa/YOCTO_5621

Valentin Popa (1):
  Hob: check if warnings are related to package build

 bitbake/lib/bb/ui/crumbs/runningbuild.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.8.3.2


