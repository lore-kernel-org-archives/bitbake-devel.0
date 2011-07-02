Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1Qd24c-0002xf-Ez
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jul 2011 17:25:34 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 02 Jul 2011 08:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,463,1304319600"; d="scan'208";a="22701235"
Received: from dcui-desktop.sh.intel.com (HELO localhost) ([10.239.36.71])
	by orsmga001.jf.intel.com with ESMTP; 02 Jul 2011 08:15:27 -0700
From: Dexuan Cui <dexuan.cui@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Jul 2011 23:15:29 +0800
Message-Id: <cover.1309619557.git.dexuan.cui@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1][v3] bitbake/cooker, bitbake-layers: show the .bbappend files that matches no existing .bb recipe
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
X-List-Received-Date: Sat, 02 Jul 2011 15:25:34 -0000

The following changes since commit 2152759b50cc3acc96ee57b242e0b896e65f5e93:

  sanity.bbclass: only run check_pseudo_wrapper for bitbake (2011-06-19 19:50:46 +0800)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dcui/bb-v3
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dcui/bb-v3

Dexuan Cui (1):
  bitbake/cooker, bitbake-layers: show the .bbappend files that matches
    no existing .bb recipe

 bitbake/bin/bitbake-layers |   21 +--------------------
 bitbake/lib/bb/cooker.py   |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 20 deletions(-)

-- 
1.7.6



