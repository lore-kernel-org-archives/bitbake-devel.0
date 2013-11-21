Return-Path: <valentin.popa@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id BBBE56B1A9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2013 11:54:21 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 21 Nov 2013 03:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,743,1378882800"; d="scan'208";a="412351515"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by orsmga001.jf.intel.com with ESMTP; 21 Nov 2013 03:54:16 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2013 13:55:12 +0200
Message-Id: <cover.1385034591.git.valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [PATCH 0/1] HOB: Show warnings in Issues tab
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
X-List-Received-Date: Thu, 21 Nov 2013 11:54:21 -0000


The following changes since commit 725fae65810c477882f7f9d02561362b3f603db0:

  bitbake: toasterui: fix typo (2013-11-20 14:06:49 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib vpopa/YOCTO_3496
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=vpopa/YOCTO_3496

Valentin Popa (1):
  HOB: Show warnings in Issues tab

 bitbake/lib/bb/ui/crumbs/runningbuild.py | 48 ++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 15 deletions(-)

-- 
1.8.3.2


