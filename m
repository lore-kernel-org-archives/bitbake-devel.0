Return-Path: <valentin.popa@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5F4FF6D750
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2013 09:29:46 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Nov 2013 01:29:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,773,1378882800"; d="scan'208";a="434194237"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by fmsmga001.fm.intel.com with ESMTP; 26 Nov 2013 01:29:45 -0800
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Nov 2013 11:30:40 +0200
Message-Id: <cover.1385457669.git.valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.3.2
Subject: [PATCH 0/1] Hob: force notebook refresh
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
X-List-Received-Date: Tue, 26 Nov 2013 09:29:46 -0000


The following changes since commit 381cd842caa3db5eabf8973305b6979014d9d0a8:

  linux-firmware: add missing linux-firmware-iwlwifi-7260-7 package (2013-11-25 16:14:48 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib vpopa/YOCTO_5596
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=vpopa/YOCTO_5596

Valentin Popa (1):
  Hob: force notebook refresh

 bitbake/lib/bb/ui/crumbs/builddetailspage.py | 1 +
 1 file changed, 1 insertion(+)

-- 
1.8.3.2


