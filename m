Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S0UVQ-0002qm-2Z
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 09:58:28 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 23 Feb 2012 00:50:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="113857063"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.62])
	by orsmga002.jf.intel.com with ESMTP; 23 Feb 2012 00:50:05 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 16:49:23 +0800
Message-Id: <cover.1329986451.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] Add new option --environment-more
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
X-List-Received-Date: Thu, 23 Feb 2012 08:58:28 -0000

This patch adds a new option --environment-more to bitbake to display 
additional file dependency information. This kind of information can be used 
by other recipe editors, e.g. the Eclipse bitbake commander plugin, to decide 
when to reparse the recipes.

The following changes since commit d8b3718303c3d56394c722059f1a73bd79131d0a:
  Zhai Edwin (1):
        texi2html: Fix for multilib

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/bitbake_showmore
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bitbake_showmore

Lianhao Lu (1):
  bitbake: Add new otpion --environment-more

 bitbake/bin/bitbake       |    3 +++
 bitbake/lib/bb/command.py |    6 ++++--
 bitbake/lib/bb/cooker.py  |   22 ++++++++++++++++++----
 scripts/bitbake           |    2 +-
 4 files changed, 26 insertions(+), 7 deletions(-)



