Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QYWGi-0000pO-KR
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Jun 2011 06:39:24 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 Jun 2011 21:34:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,391,1304319600"; d="scan'208";a="15747945"
Received: from dcui-desktop.sh.intel.com (HELO localhost) ([10.239.13.51])
	by orsmga002.jf.intel.com with ESMTP; 19 Jun 2011 21:34:29 -0700
From: Dexuan Cui <dexuan.cui@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2011 12:34:14 +0800
Message-Id: <cover.1308544082.git.dexuan.cui@intel.com>
X-Mailer: git-send-email 1.7.2
Subject: [PATCH 0/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Mon, 20 Jun 2011 04:39:24 -0000

Please review the patch.

The following changes since commit 2152759b50cc3acc96ee57b242e0b896e65f5e93:

  sanity.bbclass: only run check_pseudo_wrapper for bitbake (2011-06-19 19:50:46 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dcui/bb
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dcui/bb

Dexuan Cui (1):
  die if a .bbappend file matches no existing .bb recipe

 bitbake/bin/bitbake-layers |   19 -------------------
 bitbake/lib/bb/cooker.py   |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)



